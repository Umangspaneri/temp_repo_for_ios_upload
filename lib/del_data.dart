import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountScreen extends StatefulWidget {
  final String userEmail;
  final String userName;

  const DeleteAccountScreen({super.key, required this.userEmail, required this.userName});

  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _message = '';
  bool _isAccountDeleted = false;  // Track if the account is deleted

  // Delete account logic
  Future<void> _deleteAccount() async {
    String enteredEmail = _emailController.text.trim();
    String enteredPassword = _passwordController.text.trim();

    // Ensure email and password are entered
    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      setState(() {
        _message = "Please enter both email and password.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = '';
    });

    try {
      // Step 1: Make an HTTP POST request to validate the email and password
      final response = await http.post(
        Uri.parse('https://eqbhighrise.ca/req_del.php'), // API endpoint for validation
        body: {
          'email': enteredEmail,
          'password': enteredPassword,
        },
      );

      // Check if HTTP status code is 200
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);

        // Step 2: If credentials are valid, proceed to delete the account
        if (responseBody['status'] == 'success') {
          final deleteResponse = await http.post(
            Uri.parse('https://eqbhighrise.ca/req_del.php'), // API endpoint for deleting the account
            body: {
              'email': enteredEmail, // User's email to be deleted
            },
          );

          // Check for success status in the delete response
          if (deleteResponse.statusCode == 200) {
            final deleteResponseBody = json.decode(deleteResponse.body);

            setState(() {
              if (deleteResponseBody['status'] == 'success') {
                _message = 'Account deleted successfully.';
                _isAccountDeleted = true;  // Set flag to indicate account is deleted
                _clearSharedPreferences();
                Navigator.pushReplacementNamed(context, '/login');  // Navigate to login screen
              } else {
                _message = deleteResponseBody['message'] ?? 'An error occurred while deleting the account.';
              }
              _isLoading = false;
            });
          } else {
            setState(() {
              _isLoading = false;
              _message = 'Error deleting account: Server returned an error.';
            });
          }
        } else {
          setState(() {
            _isLoading = false;
            _message = responseBody['message'] ?? 'Invalid email or password.';
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _message = 'Error: Server returned status code ${response.statusCode}.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _message = 'An error occurred: $e';
      });
    }
  }

  // Clear SharedPreferences
  Future<void> _clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();  // Clear all saved preferences
    print('SharedPreferences cleared.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Account', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF99262B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Delete your account: ${widget.userName}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter your email',
                hintText: 'Your email address',
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Enter your password',
                hintText: 'Your password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _deleteAccount,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: _isLoading
                  ? CircularProgressIndicator()
                  : Text('Delete Account', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 20),
            if (_message.isNotEmpty)
              Text(
                _message,
                style: TextStyle(
                  color: _message == 'Account deleted successfully.' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            // Show the message only if the account is deleted
            if (_isAccountDeleted)
              Text(
                "Your account has been deleted.",
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

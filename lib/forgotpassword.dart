import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  
  bool _isLoading = false;
  String? _errorMessage;
  bool _isEmailVerified = false;  // To track if the email exists in the database
  bool _isPasswordReset = false;  // To track if the password has been reset successfully

  // API URL for resetting password
  final String resetPasswordUrl = 'https://eqbhighrise.ca/reset-password.php'; // Replace with actual API URL for resetting password
  final String checkEmailUrl = 'https://eqbhighrise.ca/check-mail.php'; // Replace with actual API URL for checking email existence

  // Step 1: Check if email exists in the database
  void _checkEmail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String email = _emailController.text;

    if (email.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(checkEmailUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'email': email}),
        );

        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');  // This will print the response body

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          if (responseData['status'] == 'success') {
            setState(() {
              _isEmailVerified = true;  // Email found in the database, allow password reset
            });
          } else {
            setState(() {
              _errorMessage = 'Email not found in the database.';
            });
          }
        } else {
          setState(() {
            _errorMessage = 'Error connecting to the server.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Please enter your email address';
        _isLoading = false;
      });
    }
  }

  // Step 2: Reset password
  void _resetPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String newPassword = _newPasswordController.text;
    String email = _emailController.text;

    if (newPassword.isNotEmpty && email.isNotEmpty) {
      try {
        final response = await http.post(
          Uri.parse(resetPasswordUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': email,
            'password': newPassword
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);

          if (responseData['status'] == 'success') {
            setState(() {
              _isPasswordReset = true; // Password has been reset
              _errorMessage = 'Password reset successful!';
            });
          } else {
            setState(() {
              _errorMessage = 'Failed to reset password.';
            });
          }
        } else {
          setState(() {
            _errorMessage = 'Error connecting to the server.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred. Please try again.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Please enter both email and new password.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'images/icon.jpg',  // Replace with your background image
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        spreadRadius: 5.0,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        _isPasswordReset
                            ? 'Password Reset Successful!'
                            : _isEmailVerified
                                ? 'Enter New Password'
                                : 'Forgot Password',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF99262B),
                        ),
                      ),
                      const SizedBox(height: 30),
                      !_isPasswordReset
                          ? !_isEmailVerified
                              ? _buildEmailField()
                              : _buildNewPasswordField()
                          : Container(),
                      if (!_isPasswordReset) ...[
                        const SizedBox(height: 20),
                        !_isEmailVerified
                            ? ElevatedButton(
                                onPressed: _checkEmail,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00316C),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text('Check Email', style: TextStyle(color: Colors.white)),
                              )
                            : ElevatedButton(
                                onPressed: _resetPassword,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF00316C),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                child: const Text('Reset Password', style: TextStyle(color: Colors.white)),
                              ),
                      ],
                      if (_isPasswordReset) ...[
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Navigate back to the login screen
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00316C),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          child: const Text('Go Back to Login', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email, color: Color(0xFF00316C)),
        hintText: 'Enter your email',
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildNewPasswordField() {
    return TextField(
      controller: _newPasswordController,
      obscureText: true,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock, color: Color(0xFF00316C)),
        hintText: 'Enter new password',
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

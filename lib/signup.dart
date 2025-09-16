// import 'dart:convert'; // For encoding JSON data
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;  // For HTTP requests
// import 'login.dart';  // Assuming you have this page
//
// class SignupScreen extends StatefulWidget {
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _uidController = TextEditingController();
//
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   // Handle Signup action
//   void _handleSignup() async {
//     // Check if any fields are empty
//     if (_usernameController.text.isEmpty ||
//         _emailController.text.isEmpty ||
//         _passwordController.text.isEmpty ||
//         _uidController.text.isEmpty) {
//       setState(() {
//         _errorMessage = "All fields are required.";
//       });
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;  // Clear any previous error message
//     });
//
//     // Prepare the data to send to the API
//     var data = {
//       'name': _usernameController.text,
//       'email': _emailController.text,
//       'password': _passwordController.text,
//       'uid': _uidController.text,
//     };
//
//     // API URL (replace with your actual API endpoint)
//     final url = 'https://eqbhighrise.ca/signup.php';
//
//     try {
//       // Send POST request to API
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(data),  // Sending the data as a JSON string
//       );
//
//       // Debugging: Print the response from the server
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//
//       // Check if the response is successful
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//
//         if (responseData['status'] == 'success') {
//           // If signup is successful
//           _showSnackBar('Sign Up Successful', Colors.green);
//           setState(() {
//             _isLoading = false;
//           });
//           // Navigate to the next screen or perform additional logic
//           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
//         } else {
//           // If signup failed but server returns a response (non-successful status)
//           _showSnackBar('Sign Up Failed: ${responseData['message']}', Colors.red);
//           setState(() {
//             _isLoading = false;
//           });
//         }
//       } else {
//         // If the server returns an error status code
//         _showSnackBar('Error: ${response.statusCode}', Colors.red);
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     } catch (error) {
//       // Handle network error or other exceptions
//       _showSnackBar('Error: $error', Colors.red);
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   // Function to show SnackBar with a message
//   void _showSnackBar(String message, Color color) {
//     // Ensure no multiple SnackBars are stacked
//     ScaffoldMessenger.of(context).clearSnackBars();
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: color,
//         duration: Duration(seconds: 3),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign-Up TO Continue',style: TextStyle(color: Colors.white),),
//         backgroundColor: Color(0xFF00316C),
//       ),
//       body: Stack(
//         children: [
//           // Background color for the whole screen
//           Container(
//             color: Color(0xFFF5F5F5), // Light grey background
//           ),
//           // Scrollable card at the bottom
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
//               child: SingleChildScrollView(
//                 child: Container(
//                   padding: EdgeInsets.all(20.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(20.0),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 10.0,
//                         spreadRadius: 5.0,
//                       ),
//                     ],
//                   ),
//                   width: double.infinity,
//                   constraints: BoxConstraints(maxWidth: 350),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       // Welcome Text
//                       Text(
//                         'Welcome to EQB',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF00316C), // Dark blue color
//                         ),
//                       ),
//                       SizedBox(height: 20),
//                       // Logo Image (Square shape)
//                       Container(
//                         width: 200,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('images/icon.jpg'), // Replace with your logo file
//                             fit: BoxFit.contain,
//                           ),
//                           shape: BoxShape.rectangle,
//                         ),
//                       ),
//                       SizedBox(height: 40),
//                       // Form Title
//                       Text(
//                         'Sign Up to Continue',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF99262B),
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                       // Signup Form
//                       _buildTextField(
//                         controller: _usernameController,
//                         hintText: 'Name',
//                         icon: Icons.person,
//                         isPassword: false,
//                       ),
//                       SizedBox(height: 10),
//                       _buildTextField(
//                         controller: _emailController,
//                         hintText: 'Email',
//                         icon: Icons.email,
//                         isPassword: false,
//                       ),
//                       SizedBox(height: 10),
//                       _buildTextField(
//                         controller: _passwordController,
//                         hintText: 'Password',
//                         icon: Icons.lock,
//                         isPassword: true,
//                       ),
//                       SizedBox(height: 10),
//                       _buildTextField(
//                         controller: _uidController,
//                         hintText: 'Unique ID',
//                         icon: Icons.card_membership,
//                         isPassword: false,
//                       ),
//                       SizedBox(height: 20),
//                       if (_isLoading) CircularProgressIndicator(),
//                       if (_errorMessage != null)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 10.0),
//                           child: Text(
//                             _errorMessage!,
//                             style: TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: _handleSignup,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF00316C),
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                           ),
//                           minimumSize: Size(double.infinity, 50),
//                         ),
//                         child: Text(
//                           'Sign Up',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           TextButton(
//                             onPressed: () {
//                               // Navigate to login page
//                               Navigator.pushReplacement(
//                                 context,
//                                 MaterialPageRoute(builder: (context) => LoginScreen()),
//                               );
//                             },
//                             child: Text(
//                               'Already a user?',
//                               style: TextStyle(color: Color(0xFF00316C)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     required IconData icon,
//     required bool isPassword,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         prefixIcon: Icon(icon, color: Color(0xFF00316C)),
//         hintText: hintText,
//         filled: true,
//         fillColor: Color(0xFFF0F0F0),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30.0),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }
// }

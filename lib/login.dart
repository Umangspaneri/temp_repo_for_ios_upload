// import 'dart:convert';
// import 'package:eqb_ltd/forgotpassword.dart';
// import 'package:eqb_ltd/home.dart';
// import 'package:eqb_ltd/privacy.dart';
// import 'package:eqb_ltd/signup.dart';
// import 'package:eqb_ltd/splash.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _usernameController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   // API URL for the backend
//   final String apiUrl =
//       'https://eqbhighrise.ca/login.php'; // Replace with your API URL
//
//   @override
//   void initState() {
//     super.initState();
//     _checkIfLoggedIn();
//   }
//
//   // Check if the user is already logged in
//   Future<void> _checkIfLoggedIn() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
//
//     if (isLoggedIn) {
//       String userName = prefs.getString('userName') ?? '';
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BottomNavBar(userName: userName),
//         ),
//       );
//     }
//   }
//
//   void _handleLogin() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//
//     String email = _usernameController.text;
//     String password = _passwordController.text;
//
//     if (email.isNotEmpty && password.isNotEmpty) {
//       try {
//         final response = await http.post(
//           Uri.parse(apiUrl),
//           headers: {
//             'Content-Type': 'application/json',
//           },
//           body: jsonEncode({
//             'email': email,
//             'password': password,
//           }),
//         );
//
//         if (response.statusCode == 200) {
//           final responseData = jsonDecode(response.body);
//
//           if (responseData['status'] == 'success') {
//             // Assuming 'name' is part of the response (update based on your response format)
//             String? userName =
//                 responseData['user']['name']; // Use nullable String
//
//             // Save the login status and user name in shared preferences
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             prefs.setBool('isLoggedIn', true);
//             prefs.setString('userName',
//                 userName ?? 'Guest'); // Save a fallback name in case it's null
//
//             // Login successful, pass the user's name to BottomNavBar
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BottomNavBar(
//                     userName:
//                         userName ?? 'Guest'), // Pass the name with fallback
//               ),
//             );
//           } else {
//             setState(() {
//               _errorMessage = responseData['message'];
//               _isLoading = false;
//             });
//           }
//         } else {
//           setState(() {
//             _errorMessage = 'Failed to connect to server.';
//             _isLoading = false;
//           });
//         }
//       } catch (e) {
//         setState(() {
//           _errorMessage = 'An error occurred. Please try again.';
//           _isLoading = false;
//           print(e);
//         });
//       }
//     } else {
//       setState(() {
//         _errorMessage = 'Please enter both email and password.';
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Login To Continue',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Color(0xFF00316C),
//         // Adding a back button in the AppBar
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => BottomNavBar(
//                           userName: 'guest',
//                         ))); // This will pop the current screen and go back to the previous screen
//           },
//         ),
//       ),
//       body: Stack(
//         children: [
//           // Background color for the whole screen
//           Container(
//             color: Color(0xFFF5F5F5), // Light grey background
//           ),
//           // Login card that is scrollable
//           SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 50.0),
//               // Adjust the top padding for vertical alignment
//               child: Center(
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
//                     mainAxisSize: MainAxisSize.min,
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
//                       SizedBox(height: 10),
//                       // Logo Image (Square shape)
//                       Container(
//                         width: 200,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage('images/icon.jpg'),
//                             // Replace with your logo file
//                             fit: BoxFit.contain,
//                           ),
//                           shape: BoxShape.rectangle,
//                         ),
//                       ),
//                       SizedBox(height: 40),
//                       // Login Form
//                       _buildTextField(
//                         controller: _usernameController,
//                         hintText: 'Email',
//                         icon: Icons.person,
//                         isPassword: false,
//                       ),
//                       SizedBox(height: 20),
//                       _buildTextField(
//                         controller: _passwordController,
//                         hintText: 'Password',
//                         icon: Icons.lock,
//                         isPassword: true,
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
//                         onPressed: _handleLogin,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFF00316C),
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0),
//                           ),
//                           minimumSize: Size(double.infinity, 50),
//                         ),
//                         child: Text('Login',
//                             style: TextStyle(color: Colors.white)),
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // TextButton(
//                           //   onPressed: () {
//                           //   //   Navigator.push(
//                           //   //       context,
//                           //   //       // MaterialPageRoute(
//                           //   //       //   // builder: (context) => SignupScreen(),
//                           //   //       // ));
//                           //   // },
//                           //   child: Text(
//                           //     '  New User ?',
//                           //     style: TextStyle(color: Color(0xFF00316C)),
//                           //   ),
//                           // ),
//                           Text('|', style: TextStyle(color: Colors.grey)),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           ForgotPasswordScreen()));
//                             },
//                             child: Text(
//                               'Forgot Password?',
//                               style: TextStyle(color: Color(0xFF00316C)),
//                             ),
//                           ),
//                         ],
//                       ),
//                       TextButton(
//                           onPressed: () => {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => privacy()))
//                               },
//                           child: Text(
//                             'Privacy Policy',
//                             style: TextStyle(color: Color(0xFF00316C)),
//                           ))
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

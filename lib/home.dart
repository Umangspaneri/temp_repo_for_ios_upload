// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'login.dart';
// import 'del_data.dart'; // Import delete account screen
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({Key? key, required String userName}) : super(key: key);
//   @override
//   State<StatefulWidget> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   bool _isLoggedIn = false; // Track login state
//   String _userName = ''; // Store user name
//   String _email = ''; // Store user email
//   bool _isLoading = true; // Show loading state
//   late SharedPreferences _prefs;
//   late WebViewController _controller;
//   late double _progress;
//   bool _isControllerInitialized = false; // Flag to track initialization
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeLoginState();
//     _progress = 0;
//     _initializeWebView();
//   }
//
//   // Fetch login state and user name from SharedPreferences
//   Future<void> _initializeLoginState() async {
//     _prefs = await SharedPreferences.getInstance();
//     bool loggedIn = _prefs.getBool('isLoggedIn') ?? false;
//     String userName = _prefs.getString('userName') ?? '';
//     String email = _prefs.getString('email') ?? '';
//
//     setState(() {
//       _isLoggedIn = loggedIn;
//       _userName = userName;
//       _email = email;
//       _isLoading = false;
//     });
//   }
//
//   // Initialize WebView after platform is ready
//   Future<void> _initializeWebView() async {
//     await WebViewPlatform.instance; // Ensure platform is ready
//
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             setState(() {
//               _progress = progress / 100;
//             });
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       // Load the default website link
//       ..loadRequest(Uri.parse('https://rentpedia.ca/index2.php'));
//
//     setState(() {
//       _isControllerInitialized = true; // Mark controller as initialized
//     });
//   }
//   // Logout function
//   Future<void> _logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear(); // Clear all preferences
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//           builder: (context) => LoginScreen()), // Navigate back to Login
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: _buildDrawer(),
//       appBar: AppBar(
//         title: Text(
//           'Rentpedia',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.green,
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator()) // Show loading indicator
//           : _isControllerInitialized
//               ? WebViewWidget(
//                   controller: _controller) // Show the WebView once initialized
//               : Center(
//                   child:
//                       CircularProgressIndicator()), // Show loading state while WebView is initializing
//     );
//   }
//   // Build the Drawer Widget
//   Widget _buildDrawer() {
//     return Drawer(
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFC8E6C9), Color(0xFFF1F8E9)], // Light minty gradient
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             // 🔰 Logo Container with soft shadow
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   child: Image.asset(
//                     'images/logo.jpg',
//                     fit: BoxFit.contain,
//                     height: 100,
//                   ),
//                 ),
//               ),
//             ),
//
//             // 🧭 Drawer menu items
//             ListTile(
//               leading: Icon(Icons.home, color: Colors.grey[800]),
//               title: Text('Home', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.business, color: Colors.grey[800]),
//               title: Text('Tenant', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.info, color: Colors.grey[800]),
//               title: Text('About', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.folder, color: Colors.grey[800]),
//               title: Text('Portfolio', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: Icon(Icons.contact_mail, color: Colors.grey[800]),
//               title: Text('Contact', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



//without that login code
//
// import 'package:eqb_ltd/about.dart';
// import 'package:eqb_ltd/cont.dart';
// import 'package:eqb_ltd/port.dart';
// import 'package:eqb_ltd/tenant.dart';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   late WebViewController _controller; // Declare WebViewController
//   late double _progress;
//   bool _isControllerInitialized = false;
//
//   int _page = 0; // Tracks selected page
//   late List<Widget> _pages; // List of screen widgets
//
//   @override
//   void initState() {
//     super.initState();
//     _progress = 0;
//
//     // Initialize the WebView controller first
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             setState(() {
//               _progress = progress / 100;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//
//     // Now initialize the _pages list after _controller is initialized
//     _pages = [
//       WebViewWidget(controller: _controller), // Home
//       ServiceRequestForm(),
//       about(),
//       portfolio(),
//       cont(),
//     ];
//
//     _initializeWebView(); // Initialize WebView after setting up _controller
//   }
//
//   Future<void> _initializeWebView() async {
//     // Load URL after the controller is initialized
//     await _controller.loadRequest(Uri.parse('https://rentpedia.ca/index2.php'));
//
//     setState(() {
//       _isControllerInitialized = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: _buildDrawer(), // Drawer preserved
//       appBar: AppBar(
//         title: Text('Rentpedia', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.green,
//       ),
//       body: _isControllerInitialized
//           ? IndexedStack(
//               index: _page,
//               children: _pages,
//             )
//           : Center(
//               child:
//                   CircularProgressIndicator()), // Show loading until initialized
//     );
//   }
//
//   Widget _buildDrawer() {
//     return Drawer(
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFC8E6C9), Color(0xFFF1F8E9)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   child: Image.asset(
//                     'images/logo.jpg',
//                     fit: BoxFit.contain,
//                     height: 100,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.home, color: Colors.grey[800]),
//               title: Text('Home', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() => _page = 0); // Home
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.business, color: Colors.grey[800]),
//               title: Text('Tenant', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() => _page = 1); // Tenant
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.info, color: Colors.grey[800]),
//               title: Text('About', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() => _page = 2); // About
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.folder, color: Colors.grey[800]),
//               title:
//                   Text('Portfolio', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() => _page = 3); // Portfolio
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.contact_mail, color: Colors.grey[800]),
//               title: Text('Contact', style: TextStyle(color: Colors.grey[800])),
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() => _page = 4); // Contact
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// // Widget _buildDrawer() {
// //   return Drawer(
// //     child: ListView(
// //       padding: EdgeInsets.zero,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.all(12.0),
// //           child: Material(
// //             elevation: 4,
// //             borderRadius: BorderRadius.circular(12),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               padding: const EdgeInsets.all(16),
// //               child: Image.asset(
// //                 'images/logo.jpg',
// //                 fit: BoxFit.contain,
// //                 height: 100,
// //               ),
// //             ),
// //           ),
// //         ),
// //         // Drawer items
// //         ListTile(
// //           leading: Icon(Icons.home, color: Colors.grey[800]),
// //           title: Text('Home', style: TextStyle(color: Colors.grey[800])),
// //           onTap: () {
// //             Navigator.pop(context);
// //             setState(() {
// //               _page = 0;  // Home - Sync Drawer with BottomNavigationBar
// //             });
// //           },
// //         ),
// //         ListTile(
// //           leading: Icon(Icons.business, color: Colors.grey[800]),
// //           title: Text('Tenant', style: TextStyle(color: Colors.grey[800])),
// //           onTap: () {
// //             Navigator.pop(context);
// //             setState(() {
// //               _page = 1;  // Tenant - Sync Drawer with BottomNavigationBar
// //             });
// //           },
// //         ),
// //         ListTile(
// //           leading: Icon(Icons.info, color: Colors.grey[800]),
// //           title: Text('About', style: TextStyle(color: Colors.grey[800])),
// //           onTap: () {
// //             Navigator.pop(context);
// //             setState(() {
// //               _page = 2;  // About - Sync Drawer with BottomNavigationBar
// //             });
// //           },
// //         ),
// //         ListTile(
// //           leading: Icon(Icons.folder, color: Colors.grey[800]),
// //           title: Text('Portfolio', style: TextStyle(color: Colors.grey[800])),
// //           onTap: () {
// //             Navigator.pop(context);
// //             setState(() {
// //               _page = 3;  // Portfolio - Sync Drawer with BottomNavigationBar
// //             });
// //           },
// //         ),
// //         ListTile(
// //           leading: Icon(Icons.contact_mail, color: Colors.grey[800]),
// //           title: Text('Contact', style: TextStyle(color: Colors.grey[800])),
// //           onTap: () {
// //             Navigator.pop(context);
// //             setState(() {
// //               _page = 4;  // Contact - Sync Drawer with BottomNavigationBar
// //             });
// //           },
// //         ),
// //       ],
// //     ),
// //   );
// // }
// }
//
// import 'package:flutter/material.dart';
// import 'package:eqb_ltd/about.dart';
// import 'package:eqb_ltd/cont.dart';
// import 'package:eqb_ltd/port.dart';
// import 'package:eqb_ltd/tenant.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   late WebViewController _controller; // Declare WebViewController
//   late double _progress;
//   bool _isControllerInitialized = false;
//
//  @override
//   void initState() {
//     super.initState();
//     _progress = 0;
//
//     // Initialize the WebView controller first
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             setState(() {
//               _progress = progress / 100;
//             });
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//
//     _initializeWebView(); // Initialize WebView after setting up _controller
//   }
//
//   Future<void> _initializeWebView() async {
//     // Load URL after the controller is initialized
//     await _controller.loadRequest(Uri.parse('https://rentpedia.ca/index2.php'));
//
//     setState(() {
//       _isControllerInitialized = true;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: _buildDrawer(), // Drawer preserved
//       appBar: AppBar(
//         title: Text("Rentpedia", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.green,
//       ),
//       body: Center(
//           child:
//           CircularProgressIndicator()), // Show loading until initialized
//     );
//   }
//
//   Widget _buildDrawer() {
//     return Drawer(
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFFC8E6C9), Color(0xFFF1F8E9)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Material(
//                 elevation: 4,
//                 borderRadius: BorderRadius.circular(12),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   padding: const EdgeInsets.all(16),
//                   child: Image.asset(
//                     'images/logo.jpg', // Your logo here
//                     fit: BoxFit.contain,
//                     height: 100,
//                   ),
//                 ),
//               ),
//             ),
//                       ],
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   late WebViewController _controller;
//   bool _isControllerInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onNavigationRequest: (NavigationRequest request) {
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//
//     _initializeWebView();
//   }
//
//   Future<void> _initializeWebView() async {
//     await _controller.loadRequest(
//       Uri.parse('https://rentpedia.ca/index2.php'),
//     );
//
//     setState(() {
//       _isControllerInitialized = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: _isControllerInitialized
//           ? WebViewWidget(controller: _controller)
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
//
// }
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'offline_screen.dart';
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   late WebViewController _controller;
//   bool _isControllerInitialized = false;
//   bool isOffline = false;
//
//   @override
//   void initState() {
//     super.initState();
//     checkConnectivity();
//
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onNavigationRequest: (NavigationRequest request) {
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//
//     _initializeWebView();
//   }
//
//   Future<void> checkConnectivity() async {
//     final result = await Connectivity().checkConnectivity();
//     setState(() {
//       isOffline = result == ConnectivityResult.none;
//     });
//   }
//
//   Future<void> _initializeWebView() async {
//     await _controller.loadRequest(
//       Uri.parse('https://rentpedia.ca/index2.php'),
//     );
//
//     setState(() {
//       _isControllerInitialized = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isOffline) {
//       return OfflineScreen(retry: checkConnectivity);
//     }
//
//     return Scaffold(
//       body: _isControllerInitialized
//           ? WebViewWidget(controller: _controller)
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'offline_screen.dart';
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewPage> createState() => _WebViewPageState();
// }
//
// class _WebViewPageState extends State<WebViewPage> {
//   late WebViewController _controller;
//   bool _isControllerInitialized = false;
//   bool isOffline = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _setupWebView();
//     _monitorConnectivity();
//   }
//
//   void _setupWebView() {
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onNavigationRequest: (NavigationRequest request) {
//             return NavigationDecision.navigate;
//           },
//         ),
//       );
//   }
//
//   void _monitorConnectivity() {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       bool currentlyOffline = result == ConnectivityResult.none;
//
//       if (currentlyOffline != isOffline) {
//         setState(() {
//           isOffline = currentlyOffline;
//         });
//
//         if (!currentlyOffline && !_isControllerInitialized) {
//           _initializeWebView();
//         }
//       }
//     });
//
//     // Initial check
//     Connectivity().checkConnectivity().then((result) {
//       setState(() {
//         isOffline = result == ConnectivityResult.none;
//       });
//
//       if (!isOffline) {
//         _initializeWebView();
//       }
//     });
//   }
//
//   Future<void> _initializeWebView() async {
//     await _controller.loadRequest(
//       Uri.parse('https://rentpedia.ca/index2.php'),
//     );
//
//     setState(() {
//       _isControllerInitialized = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isOffline) {
//       return OfflineScreen(
//         retry: () async {
//           final result = await Connectivity().checkConnectivity();
//           if (result != ConnectivityResult.none) {
//             setState(() {
//               isOffline = false;
//             });
//             if (!_isControllerInitialized) {
//               _initializeWebView();
//             }
//           }
//         },
//       );
//     }
//
//     return Scaffold(
//       body: _isControllerInitialized
//           ? WebViewWidget(controller: _controller)
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_screen.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;
  bool _isControllerInitialized = false;
  bool isOffline = false;
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _setupWebView();
    _monitorConnectivity();
  }

  void _setupWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _progress = progress / 100;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
  }


void _monitorConnectivity() {
  Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);

  Connectivity().checkConnectivity().then((result) {
    setState(() {
      isOffline = result == ConnectivityResult.none;
    });

    if (!isOffline) {
      _initializeWebView();
    }
  });
}

void _updateConnectionStatus(List<ConnectivityResult> results) {
  final result = results.isNotEmpty ? results.first : ConnectivityResult.none;
  bool currentlyOffline = result == ConnectivityResult.none;

  if (currentlyOffline != isOffline) {
    setState(() {
      isOffline = currentlyOffline;
    });

    if (!currentlyOffline && !_isControllerInitialized) {
      _initializeWebView();
    }
  }
}


  Future<void> _initializeWebView() async {
    await _controller.loadRequest(
      Uri.parse('https://rentpedia.ca/index2.php'),
    );

    setState(() {
      _isControllerInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isOffline) {
      return OfflineScreen(
        retry: () async {
          final result = await Connectivity().checkConnectivity();
          if (result != ConnectivityResult.none) {
            setState(() {
              isOffline = false;
            });
            if (!_isControllerInitialized) {
              _initializeWebView();
            }
          }
        },
      );
    }

    if (!_isControllerInitialized) {
      return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Rentpedia'),
        //   backgroundColor: const Color(0xFF99262B),
        // ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Rentpedia'),
      //   backgroundColor: const Color(0xFF99262B),
      //   bottom: PreferredSize(
      //     preferredSize: const Size.fromHeight(6.0),
      //     child: LinearProgressIndicator(
      //       backgroundColor: theme.colorScheme.onPrimary,
      //       valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
      //       value: _progress,
      //     ),
      //   ),
      // ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

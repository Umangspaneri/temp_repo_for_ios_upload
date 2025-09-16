// // import 'package:flutter/material.dart';
// // import 'package:webview_flutter/webview_flutter.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// //
// // class ServiceRequestForm extends StatefulWidget {
// //   final Function(String)? onLogin;
// //
// //   const ServiceRequestForm({Key? key, this.onLogin}) : super(key: key);
// //
// //   @override
// //   _ServiceRequestFormState createState() => _ServiceRequestFormState();
// // }
// //
// // class _ServiceRequestFormState extends State<ServiceRequestForm> {
// //   late final WebViewController _controller;
// //   bool _hasRedirected = false;
// //   bool _fetchedUserName = false;
// //   String? userName;
// //   bool isLoggedIn = false;
// //   bool showOptions = true;
// //   @override
// //   void initState() {
// //     super.initState();
// //     _controller = WebViewController()
// //       ..setJavaScriptMode(JavaScriptMode.unrestricted)
// //       ..setNavigationDelegate(
// //         NavigationDelegate(
// //           onPageFinished: (String url) {
// //             // Detect logout
// //             if (url.contains("tenant-login2.php")) {
// //               setState(() {
// //                 isLoggedIn = false;
// //                 userName = null;
// //                 _fetchedUserName = false;
// //               });
// //             }
// //
// //             // Detect login success
// //             if (!_hasRedirected && url.contains("tenant-services2.php")) {
// //               _hasRedirected = true;
// //               Fluttertoast.showToast(
// //                 msg: "Login Successful!",
// //                 toastLength: Toast.LENGTH_SHORT,
// //                 gravity: ToastGravity.BOTTOM,
// //                 backgroundColor: Colors.green,
// //                 textColor: Colors.white,
// //               );
// //
// //               setState(() {
// //                 isLoggedIn = true;
// //               });
// //
// //               Future.delayed(Duration(seconds: 1), () {
// //                 _controller.loadRequest(
// //                     Uri.parse("https://rentpedia.ca/tenant-services2.php"));
// //               });
// //             }
// //
// //             // Get user name after login
// //             if (url.contains("tenant-services2.php") && !_fetchedUserName) {
// //               _fetchedUserName = true;
// //               _controller
// //                   .runJavaScriptReturningResult(
// //                       "document.getElementById('userNameElement')?.innerText")
// //                   .then((result) {
// //                 if (result != null) {
// //                   final cleaned = result.toString().replaceAll('"', '');
// //                   setState(() {
// //                     userName = cleaned;
// //                   });
// //                   if (widget.onLogin != null) {
// //                     widget.onLogin!(cleaned);
// //                   }
// //                 }
// //               });
// //             }
// //           },
// //         ),
// //       )
// //       ..loadRequest(Uri.parse("https://rentpedia.ca/tenant-login2.php"));
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return PopScope(
// //       canPop: true,
// //       onPopInvoked: (didPop) async {
// //         if (!didPop && await _controller.canGoBack()) {
// //           _controller.goBack();
// //         }
// //       },
// //       child: Scaffold(
// //         appBar: AppBar(
// //           backgroundColor: Colors.green,
// //           title: Text(
// //             userName != null && userName!.isNotEmpty
// //                 ? 'Welcome, $userName' : 'Tenant', ),
// //           leading: isLoggedIn
// //               ? IconButton(
// //                   icon: Icon(Icons.arrow_back),
// //                   onPressed: () async {
// //                     if (await _controller.canGoBack()) {
// //                       _controller.goBack();
// //                     } else {
// //                       Navigator.of(context).pop();
// //                     }
// //                   },
// //                 )
// //               : null,
// //         ),
// //         body: WebViewWidget(controller: _controller),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class ServiceRequestForm extends StatefulWidget {
//   final Function(String)? onLogin;
//
//   const ServiceRequestForm({Key? key, this.onLogin}) : super(key: key);
//
//   @override
//   _ServiceRequestFormState createState() => _ServiceRequestFormState();
// }
//
// class _ServiceRequestFormState extends State<ServiceRequestForm> {
//   late final WebViewController _controller;
//   bool _hasRedirected = false;
//   bool _fetchedUserName = false;
//   String? userName;
//   bool isLoggedIn = false;
//   bool showOptions = true; // <-- Step 1
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) {
//             if (url.contains("tenant-login2.php")) {
//               setState(() {
//                 isLoggedIn = false;
//                 userName = null;
//                 _fetchedUserName = false;
//               });
//             }
//
//             if (!_hasRedirected && url.contains("tenant-services2.php")) {
//               _hasRedirected = true;
//               Fluttertoast.showToast(
//                 msg: "Login Successful!",
//                 backgroundColor: Colors.green,
//                 textColor: Colors.white,
//               );
//
//               setState(() {
//                 isLoggedIn = true;
//               });
//
//               Future.delayed(Duration(seconds: 1), () {
//                 _controller.loadRequest(
//                     Uri.parse("https://rentpedia.ca/tenant-services2.php"));
//               });
//             }
//
//             if (url.contains("tenant-services2.php") && !_fetchedUserName) {
//               _fetchedUserName = true;
//               _controller
//                   .runJavaScriptReturningResult(
//                       "document.getElementById('userNameElement')?.innerText")
//                   .then((result) {
//                 if (result != null) {
//                   final cleaned = result.toString().replaceAll('"', '');
//                   setState(() {
//                     userName = cleaned;
//                   });
//                   if (widget.onLogin != null) {
//                     widget.onLogin!(cleaned);
//                   }
//                 }
//               });
//             }
//           },
//         ),
//       );
//   }
//
//   // Step 5: Open URL in external browser
//   Future<void> _launchExternalUrl() async {
//     final Uri url = Uri.parse("https://www.securecafenet.com/residentservices/apartmentsforrent/userlogin");
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       Fluttertoast.showToast(msg: "Could not open URL");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,
//       onPopInvoked: (didPop) async {
//         if (!didPop && await _controller.canGoBack()) {
//           _controller.goBack();
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text(
//             showOptions
//                 ? 'Tenant'
//                 : (isLoggedIn && userName != null && userName!.isNotEmpty
//                     ? 'Welcome, $userName'
//                     : 'Tenant Login'),
//           ),
//           leading: !showOptions
//               ? IconButton(
//                   icon: Icon(Icons.arrow_back),
//                   onPressed: () async {
//                     // If WebView can go back, go back inside web pages
//                     if (await _controller.canGoBack()) {
//                       _controller.goBack();
//                     } else {
//                       // Else, go back to button screen
//                       setState(() {
//                         showOptions = true;
//                         isLoggedIn = false;
//                         userName = null;
//                         _fetchedUserName = false;
//                         _hasRedirected = false;
//                       });
//                     }
//                   },
//                 )
//               : null,
//         ),
//
//         // Step 3: Conditional UI
//         // body: showOptions
//         //     ? Padding(
//         //         padding: const EdgeInsets.all(24.0),
//         //         child: Column(
//         //           mainAxisAlignment: MainAxisAlignment.center,
//         //           children: [
//         //             ElevatedButton(
//         //               style: ElevatedButton.styleFrom(
//         //                 backgroundColor: Colors.green,
//         //                 minimumSize: Size(double.infinity, 60),
//         //               ),
//         //               onPressed: () {
//         //                 setState(() {
//         //                   showOptions = false;
//         //                 });
//         //                 _controller.loadRequest(Uri.parse(
//         //                     "https://rentpedia.ca/tenant-login2.php"));
//         //               },
//         //               child: Text("Login", style: TextStyle(fontSize: 18)),
//         //             ),
//         //             SizedBox(height: 24),
//         //             ElevatedButton(
//         //               style: ElevatedButton.styleFrom(
//         //                 backgroundColor: Colors.orange,
//         //                 minimumSize: Size(double.infinity, 60),
//         //               ),
//         //               onPressed: _launchExternalUrl,
//         //               child: Text("Other Services",
//         //                   style: TextStyle(fontSize: 18)),
//         //             ),
//         //           ],
//         //         ),
//         //       )
//         //     : WebViewWidget(controller: _controller),
//         body: showOptions
//             ? Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton.icon(
//                 icon: Icon(Icons.login),
//                 label: Text("Tenant Services", style: TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF2E7D32), // your app's green
//                   foregroundColor: Colors.white,
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   minimumSize: Size(double.infinity, 60),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     showOptions = false;
//                   });
//                   _controller.loadRequest(
//                     Uri.parse("https://rentpedia.ca/tenant-login2.php"),
//                   );
//                 },
//               ),
//               SizedBox(height: 24),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.open_in_browser),
//                 label: Text("Rent Payment", style: TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFFFA726), // light orange
//                   foregroundColor: Colors.white,
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   minimumSize: Size(double.infinity, 60),
//                 ),
//                 onPressed: _launchExternalUrl,
//               ),
//             ],
//           ),
//         )
//             : WebViewWidget(controller: _controller),
//
//       ),
//     );
//   }
// }

//no internet
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// class ServiceRequestForm extends StatefulWidget {
//   final Function(String)? onLogin;
//
//   const ServiceRequestForm({Key? key, this.onLogin}) : super(key: key);
//
//   @override
//   _ServiceRequestFormState createState() => _ServiceRequestFormState();
// }
//
// class _ServiceRequestFormState extends State<ServiceRequestForm> {
//   late final WebViewController _controller;
//   bool _hasRedirected = false;
//   bool _fetchedUserName = false;
//   String? userName;
//   bool isLoggedIn = false;
//   bool showOptions = true;
//   bool _isOnline = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkConnection();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (String url) {
//             if (url.contains("tenant-login2.php")) {
//               setState(() {
//                 isLoggedIn = false;
//                 userName = null;
//                 _fetchedUserName = false;
//               });
//             }
//
//             if (!_hasRedirected && url.contains("tenant-services2.php")) {
//               _hasRedirected = true;
//               Fluttertoast.showToast(
//                 msg: "Login Successful!",
//                 backgroundColor: Colors.green,
//                 textColor: Colors.white,
//               );
//
//               setState(() {
//                 isLoggedIn = true;
//               });
//
//               Future.delayed(Duration(seconds: 1), () {
//                 _controller.loadRequest(
//                     Uri.parse("https://rentpedia.ca/tenant-services2.php"));
//               });
//             }
//
//             if (url.contains("tenant-services2.php") && !_fetchedUserName) {
//               _fetchedUserName = true;
//               _controller
//                   .runJavaScriptReturningResult(
//                   "document.getElementById('userNameElement')?.innerText")
//                   .then((result) {
//                 if (result != null) {
//                   final cleaned = result.toString().replaceAll('"', '');
//                   setState(() {
//                     userName = cleaned;
//                   });
//                   if (widget.onLogin != null) {
//                     widget.onLogin!(cleaned);
//                   }
//                 }
//               });
//             }
//           },
//         ),
//       );
//   }
//
//   Future<void> _checkConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     setState(() {
//       _isOnline = connectivityResult != ConnectivityResult.none;
//     });
//   }
//
//   Future<void> _launchExternalUrl() async {
//     final Uri url = Uri.parse(
//         "https://www.securecafenet.com/residentservices/apartmentsforrent/userlogin");
//     if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
//       Fluttertoast.showToast(msg: "Could not open URL");
//     }
//   }
//
//   Widget _offlineScreen() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24.0),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.cloud_off, size: 100, color: Colors.grey.shade400),
//             SizedBox(height: 30),
//             Text("You're Offline",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             SizedBox(height: 10),
//             Text("Please check your internet connection and try again.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
//             SizedBox(height: 30),
//             ElevatedButton.icon(
//               onPressed: () async {
//                 await _checkConnection();
//                 if (_isOnline && !showOptions) {
//                   _controller.loadRequest(
//                       Uri.parse("https://rentpedia.ca/tenant-login2.php"));
//                 }
//               },
//               icon: Icon(Icons.refresh),
//               label: Text("Retry"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,
//       onPopInvoked: (didPop) async {
//         if (!didPop && await _controller.canGoBack()) {
//           _controller.goBack();
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text(
//             showOptions
//                 ? 'Tenant'
//                 : (isLoggedIn && userName != null && userName!.isNotEmpty
//                 ? 'Welcome, $userName'
//                 : 'Tenant Login'),
//           ),
//           leading: !showOptions
//               ? IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () async {
//               if (await _controller.canGoBack()) {
//                 _controller.goBack();
//               } else {
//                 setState(() {
//                   showOptions = true;
//                   isLoggedIn = false;
//                   userName = null;
//                   _fetchedUserName = false;
//                   _hasRedirected = false;
//                 });
//               }
//             },
//           )
//               : null,
//         ),
//         body: !_isOnline
//             ? _offlineScreen()
//             : showOptions
//             ? Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton.icon(
//                 icon: Icon(Icons.login),
//                 label: Text("Tenant Services",
//                     style: TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF2E7D32),
//                   foregroundColor: Colors.white,
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   minimumSize: Size(double.infinity, 60),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     showOptions = false;
//                   });
//                   _controller.loadRequest(Uri.parse(
//                       "https://rentpedia.ca/tenant-login2.php"));
//                 },
//               ),
//               SizedBox(height: 24),
//               ElevatedButton.icon(
//                 icon: Icon(Icons.open_in_browser),
//                 label: Text("Rent Payment",
//                     style: TextStyle(fontSize: 18)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFFFFA726),
//                   foregroundColor: Colors.white,
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   minimumSize: Size(double.infinity, 60),
//                 ),
//                 onPressed: _launchExternalUrl,
//               ),
//             ],
//           ),
//         )
//             : WebViewWidget(controller: _controller),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_screen.dart'; // ✅ Import your shared offline UI
import 'package:shared_preferences/shared_preferences.dart';


Future<void> saveLoginState(String userName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('userName', userName);
}

Future<void> clearLoginState() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

Future<Map<String, dynamic>> loadLoginState() async {
  final prefs = await SharedPreferences.getInstance();
  final loggedIn = prefs.getBool('isLoggedIn') ?? false;
  final name = prefs.getString('userName') ?? '';
  return {
    'isLoggedIn': loggedIn,
    'userName': name,
  };
}


class ServiceRequestForm extends StatefulWidget {
  final Function(String)? onLogin;

  const ServiceRequestForm({super.key, this.onLogin});

  @override
  _ServiceRequestFormState createState() => _ServiceRequestFormState();
}

class _ServiceRequestFormState extends State<ServiceRequestForm> {
  late final WebViewController _controller;
  bool _hasRedirected = false;
  bool _fetchedUserName = false;
  String? userName;
  bool isLoggedIn = false;
  bool showOptions = true;
  bool _isOnline = true;

  // @override
  // void initState() {
  //   super.initState();
  //   _checkConnection();
  //   _controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onPageFinished: (String url) {
  //           if (url.contains("tenant-login2.php")) {
  //             setState(() {
  //               isLoggedIn = false;
  //               userName = null;
  //               _fetchedUserName = false;
  //             });
  //           }
  //
  //           if (!_hasRedirected && url.contains("tenant-services2.php")) {
  //             _hasRedirected = true;
  //             Fluttertoast.showToast(
  //               msg: "Login Successful!",
  //               backgroundColor: Colors.green,
  //               textColor: Colors.white,
  //             );
  //
  //             setState(() {
  //               isLoggedIn = true;
  //             });
  //
  //             Future.delayed(Duration(seconds: 1), () {
  //               _controller.loadRequest(
  //                   Uri.parse("https://rentpedia.ca/tenant-services2.php"));
  //             });
  //           }
  //
  //           if (url.contains("tenant-services2.php") && !_fetchedUserName) {
  //             _fetchedUserName = true;
  //             _controller
  //                 .runJavaScriptReturningResult(
  //                 "document.getElementById('userNameElement')?.innerText")
  //                 .then((result) {
  //               if (result != null) {
  //                 final cleaned = result.toString().replaceAll('"', '');
  //                 setState(() {
  //                   userName = cleaned;
  //                 });
  //                 if (widget.onLogin != null) {
  //                   widget.onLogin!(cleaned);
  //                 }
  //               }
  //             });
  //           }
  //         },
  //       ),
  //     );
  // }


  @override
  void initState() {
    super.initState();
    _initialize(); // ✅ new method to ensure proper order
  }
  Future<void> _initialize() async {
    await _setup();         // ✅ wait for controller setup
    await _restoreLogin();  // ✅ now safe to use controller
  }


  Future<void> _restoreLogin() async {
    final state = await loadLoginState();
    setState(() {
      isLoggedIn = state['isLoggedIn'];
      userName = state['userName'];
      showOptions = !state['isLoggedIn'];
    });

    if (state['isLoggedIn'] && _isOnline) {
      // ✅ Reload tenant services page
      _controller.loadRequest(
        Uri.parse("https://rentpedia.ca/tenant-services2.php"),
      );
    }
  }


  Future<void> _setup() async {
    await _checkConnection(); // First check internet

    if (_isOnline) {
      // Only setup WebView if internet is available
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: _handlePageFinished,
            onWebResourceError: _handleWebError,
          ),
        );
    }
  }
  void _handlePageFinished(String url) {
    if (url.contains("tenant-services2.php") && !_fetchedUserName) {
      _fetchedUserName = true;
      _controller
          .runJavaScriptReturningResult(
          "document.getElementById('userNameElement')?.innerText")
          .then((result) {
        final cleaned = result.toString().replaceAll('"', '');
        setState(() {
          userName = cleaned;
          isLoggedIn = true;
        });
        print("Restoring login with userName: $userName, isLoggedIn: $isLoggedIn");

        saveLoginState(cleaned); // ✅ Save actual username here

        if (widget.onLogin != null) {
          widget.onLogin!(cleaned);
        }
            });
    }
    print("Restored login: $isLoggedIn, userName: $userName");


    if (url.contains("tenant-services2.php") && !_fetchedUserName) {
      _fetchedUserName = true;
      _controller
          .runJavaScriptReturningResult(
          "document.getElementById('userNameElement')?.innerText")
          .then((result) {
        final cleaned = result.toString().replaceAll('"', '');
        setState(() {
          userName = cleaned;
          isLoggedIn = true;
        });

        saveLoginState(cleaned); // ✅ Save only after username is fetched

        if (widget.onLogin != null) {
          widget.onLogin!(cleaned);
        }
            });
    }

  }

  void _handleWebError(WebResourceError error) {
    Fluttertoast.showToast(
      msg: "Page failed to load. Please check your connection.",
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    setState(() {
      showOptions = true;
      isLoggedIn = false;
      userName = null;
      _fetchedUserName = false;
      _hasRedirected = false;
    });
  }


  Future<void> _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isOnline = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<void> _launchExternalUrl() async {
    final Uri url = Uri.parse(
        "https://www.securecafenet.com/residentservices/apartmentsforrent/userlogin");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Fluttertoast.showToast(msg: "Could not open URL");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        if (!didPop && await _controller.canGoBack()) {
          _controller.goBack();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            showOptions
                ? 'Tenant'
                : (isLoggedIn && userName != null && userName!.isNotEmpty
                ? 'Welcome, $userName'
                : 'Tenant Login'),
          ),
          leading: !showOptions
              ? IconButton(
            icon: Icon(Icons.arrow_back),
              onPressed: () async {
                if (await _controller.canGoBack()) {
                  _controller.goBack();
                } else {
                  await clearLoginState(); // ✅ Clear saved login
                  setState(() {
                    showOptions = true;
                    isLoggedIn = false;
                    userName = null;
                    _fetchedUserName = false;
                    _hasRedirected = false;
                  });
                }
              }

          )
              : null,
        ),
        body: !_isOnline
            ? OfflineScreen(
          retry: () async {
            await _checkConnection();
            if (_isOnline && !showOptions) {
              _controller.loadRequest(
                  Uri.parse("https://rentpedia.ca/tenant-login2.php"));
            }
          },
        )
            : showOptions
            ? Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text("Tenant Services",
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 60),
                ),
                onPressed: () {
                  setState(() {
                    showOptions = false;
                  });
                  _controller.loadRequest(Uri.parse(
                      "https://rentpedia.ca/tenant-login2.php"));
                },
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                icon: Icon(Icons.open_in_browser),
                label: Text("Rent Payment",
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFA726),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: Size(double.infinity, 60),
                ),
                onPressed: _launchExternalUrl,
              ),
            ],
          ),
        )
            : WebViewWidget(controller: _controller),
      ),
    );
  }
}
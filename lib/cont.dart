// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class cont extends StatefulWidget {
//   final Widget? title;
//
//   const cont({
//     super.key,
//     this.title,
//   });
//
//   @override
//   State<StatefulWidget> createState() => _contState();
// }
//
// class _contState extends State<cont> {
//   late WebViewController _controller;
//   late double _progress;
//   bool _isControllerInitialized = false; // Flag to track initialization
//
//   @override
//   void initState() {
//     super.initState();
//     _progress = 0;
//
//     // Initialize the WebViewController after platform is ready
//     _initializeWebView();
//   }
//
//   // Initialization of WebViewController after platform setup
//   Future<void> _initializeWebView() async {
//     await WebViewPlatform.instance;  // Ensure platform is ready
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
//             // Customize navigation requests if needed
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       // Set the default website link (e.g., Google)
//       ..loadRequest(Uri.parse('https://rentpedia.ca/contact2.php'));
//
//     setState(() {
//       _isControllerInitialized = true; // Mark controller as initialized
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     // If the controller is not initialized yet, show a loading spinner or placeholder
//     if (!_isControllerInitialized) {
//       return Scaffold(
//         appBar: AppBar(
//           title: widget.title ?? Text('Rentpedia'), // Default title if no title passed
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     // Once the controller is initialized, show the WebView
//     return Scaffold(
//
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'offline_screen.dart'; // ✅ Import your shared offline UI
//
// class cont extends StatefulWidget {
//   final Widget? title;
//
//   const cont({
//     super.key,
//     this.title,
//   });
//
//   @override
//   State<StatefulWidget> createState() => _contState();
// }
//
// class _contState extends State<cont> {
//   late WebViewController _controller;
//   late double _progress;
//   bool _isControllerInitialized = false; // Flag to track initialization
//   bool _isOnline = true; // ✅ Track connectivity
//
//   @override
//   void initState() {
//     super.initState();
//     _progress = 0;
//     _checkConnection(); // ✅ Check connectivity first
//     _initializeWebView();
//   }
//
//   // ✅ Connectivity check
//   Future<void> _checkConnection() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     setState(() {
//       _isOnline = connectivityResult != ConnectivityResult.none;
//     });
//   }
//
//   // Initialization of WebViewController after platform setup
//   Future<void> _initializeWebView() async {
//     await WebViewPlatform.instance;  // Ensure platform is ready
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
//       ..loadRequest(Uri.parse('https://rentpedia.ca/contact2.php'));
//
//     setState(() {
//       _isControllerInitialized = true;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     // ✅ Show offline screen if not connected
//     if (!_isOnline) {
//       return Scaffold(
//
//         body: OfflineScreen(
//           retry: () async {
//             await _checkConnection();
//             if (_isOnline && !_isControllerInitialized) {
//               _initializeWebView();
//             }
//           },
//         ),
//       );
//     }
//
//     // If the controller is not initialized yet, show a loading spinner or placeholder
//     if (!_isControllerInitialized) {
//       return Scaffold(
//         appBar: AppBar(
//           title: widget.title ?? Text('Rentpedia'), // Default title if no title passed
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     // Once the controller is initialized, show the WebView
//     return Scaffold(
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'offline_screen.dart';

class cont extends StatefulWidget {
  final Widget? title;

  const cont({super.key, this.title});

  @override
  State<cont> createState() => _contState();
}

class _contState extends State<cont> {
  late WebViewController _controller;
  late double _progress;
  bool _isControllerInitialized = false;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _progress = 0;
    _checkAndLoad();
  }

  Future<void> _checkAndLoad() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    bool online = connectivityResult != ConnectivityResult.none;

    setState(() {
      _isOnline = online;
    });

    if (online) {
      _initializeWebView();
    }
  }

  Future<void> _initializeWebView() async {
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
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://rentpedia.ca/contact2.php'));

    setState(() {
      _isControllerInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!_isOnline) {
      return Scaffold(
        body: OfflineScreen(
          retry: _checkAndLoad,
        ),
      );
    }

    if (!_isControllerInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: widget.title ?? const Text('Rentpedia'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: widget.title ?? const Text('Rentpedia'),
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

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class privacy extends StatefulWidget {
  final Widget? title;

  const privacy({
    super.key,
    this.title,
  });

  @override
  State<StatefulWidget> createState() => _privacyState();
}

class _privacyState extends State<privacy> {
  late WebViewController _controller;
  late double _progress;
  bool _isControllerInitialized = false; // Flag to track initialization

  @override
  void initState() {
    super.initState();
    _progress = 0;

    // Initialize the WebViewController after platform is ready
    _initializeWebView();
  }

  // Initialization of WebViewController after platform setup
  Future<void> _initializeWebView() async {
    WebViewPlatform.instance;  // Ensure platform is ready

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
            // Customize navigation requests if needed
            return NavigationDecision.navigate;
          },
        ),
      )
      // Set the default website link (e.g., Google)
      ..loadRequest(Uri.parse('https://www.termsfeed.com/live/7a677f36-72ec-47ef-8084-ce6e1e63a3ec'));

    setState(() {
      _isControllerInitialized = true; // Mark controller as initialized
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // If the controller is not initialized yet, show a loading spinner or placeholder
    if (!_isControllerInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: widget.title ?? Text('Rentpedia'), // Default title if no title passed
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Once the controller is initialized, show the WebView
    return Scaffold(
      appBar: AppBar(
        title: widget.title ?? Text('Rentpedia',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF99262B), // Default title if no title passed
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            backgroundColor: theme.colorScheme.onPrimary,
            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
            value: _progress,
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

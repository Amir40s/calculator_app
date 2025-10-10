// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class GamePage extends StatefulWidget {
//   const GamePage({super.key});
//
//   @override
//   State<GamePage> createState() => _GamePageState();
// }
//
// class _GamePageState extends State<GamePage> {
//   late WebViewController _controller;
//   bool isLoading = true; // Flag to show loading spinner until the page is fully loaded
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize the WebView plugin and wait for it to be ready
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       // Initialize WebView on Android/iOS platform
//
//       // Create a WebViewController
//       _controller = WebViewController();
//
//       // Allow JavaScript execution
//       _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
//
//       // Set up navigation delegate for logging, error handling, etc.
//       _controller.setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (String url) {
//             print("Page started loading: $url");
//             setState(() {
//               isLoading = true; // Show loading spinner
//             });
//           },
//           onPageFinished: (String url) {
//             print("Page finished loading: $url");
//             setState(() {
//               isLoading = false; // Hide loading spinner
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             print("WebView Error: ${error.description}");
//           },
//         ),
//       );
//
//       // Load the game URL
//       _controller.loadRequest(Uri.parse('https://memfog-match.preview.emergentagent.com/'));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Game'),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller), // The WebView widget displaying the game
//           // Show a loading spinner until the page is loaded
//           if (isLoading)
//             const Center(child: CircularProgressIndicator()),
//         ],
//       ),
//     );
//   }
// }

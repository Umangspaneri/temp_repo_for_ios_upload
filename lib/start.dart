
// import 'package:eqb_ltd/splash.dart';
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'dart:async';
// import 'dart:math' as math;
//
// import 'home.dart'; // BottomNavBar
// import 'offline_screen.dart'; // OfflineScreen
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _bgController;
//   late Animation<double> _fadeText;
//   late Animation<double> _scaleText;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _logoController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );
//
//     _bgController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 6),
//     )..repeat();
//
//     _fadeText = CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeIn,
//     );
//
//     _scaleText = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.elasticOut,
//     ));
//
//     _logoController.forward();
//
//     Timer(const Duration(seconds: 3), () async {
//       var connectivityResult = await Connectivity().checkConnectivity();
//       bool isOnline = connectivityResult != ConnectivityResult.none;
//
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) =>
//           isOnline ? BottomNavBar(userName: 'guest') : OfflineScreen(
//             retry: () => Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const SplashScreen()),
//             ),
//           ),
//         ),
//       );
//     });
//   }
//
//   @override
//   void dispose() {
//     _logoController.dispose();
//     _bgController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _bgController,
//       builder: (context, child) {
//         final double wave = _bgController.value * 2 * math.pi;
//
//         final Color color1 = Color.lerp(
//           const Color(0xFF0D47A1),
//           Colors.greenAccent,
//           (0.5 + 0.5 * math.sin(wave)).clamp(0.0, 1.0),
//         )!;
//
//         final Color color2 = Color.lerp(
//           Colors.greenAccent,
//           const Color(0xFF4CAF50),
//           (0.5 + 0.5 * math.sin(wave + 1)).clamp(0.0, 1.0),
//         )!;
//
//         return Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [color1, color2],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FadeTransition(
//                     opacity: _fadeText,
//                     child: ScaleTransition(
//                       scale: _scaleText,
//                       child: Image.asset(
//                         'images/logo_transparent.png',
//                         width: 240,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//

// //done code 
// import 'package:eqb_ltd/splash.dart';
// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'dart:async';
// import 'dart:math' as math;

// import 'home.dart'; // BottomNavBar
// import 'offline_screen.dart'; // OfflineScreen

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _logoController;
//   late AnimationController _bgController;
//   late Animation<double> _fadeText;
//   late Animation<double> _scaleText;

//   @override
//   void initState() {
//     super.initState();

//     _logoController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1200),
//     );

//     _bgController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 6),
//     )..repeat();

//     _fadeText = CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeIn,
//     );

//     _scaleText = Tween<double>(
//       begin: 0.8,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.elasticOut,
//     ));

//     _logoController.forward();

//     Timer(const Duration(seconds: 3), () async {
//       var connectivityResult = await Connectivity().checkConnectivity();
//       bool isOnline = connectivityResult != ConnectivityResult.none;

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => isOnline
//               ? BottomNavBar(userName: 'guest')
//               : OfflineScreen(
//             retry: () => Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const SplashScreen()),
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _bgController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _bgController,
//       builder: (context, child) {
//         final double wave = _bgController.value * 2 * math.pi;

//         // Professional dark gradient animation
//         final Color color1 = Color.lerp(
//           const Color(0xFF0D1B2A), // Deep Navy
//           const Color(0xFF1B263B), // Charcoal Blue
//           (0.5 + 0.5 * math.sin(wave)).clamp(0.0, 1.0),
//         )!;

//         final Color color2 = Color.lerp(
//           const Color(0xFF1B263B),
//           const Color(0xFF415A77), // Slate Blue
//           (0.5 + 0.5 * math.sin(wave + 1)).clamp(0.0, 1.0),
//         )!;

//         return Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [color1, color2],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   FadeTransition(
//                     opacity: _fadeText,
//                     child: ScaleTransition(
//                       scale: _scaleText,
//                       child: Container(
//                         decoration: BoxDecoration(
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.white.withOpacity(0.2),
//                               blurRadius: 16,
//                               spreadRadius: 4,
//                             ),
//                           ],
//                         ),
//                         child: Image.asset(
//                           'images/logo_transparent.png', // Use a light version of your logo
//                           width: 240,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


//fopr ios speed up

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'dart:math' as math;


// BottomNavBar
import 'offline_screen.dart'; // OfflineScreen
import 'package:eqb_ltd/splash.dart';




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _bgController;
  late final Animation<double> _fadeText;
  late final Animation<double> _scaleText;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();

    _fadeText = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    _scaleText = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoController.forward();

    // Navigate after a short fade-in and after we check connectivity
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    // Check connectivity first (async)
    var connectivityResult = await Connectivity().checkConnectivity();
    bool isOnline = connectivityResult != ConnectivityResult.none;

    // Keep splash visible briefly for animation polish (short)
    await Future.delayed(const Duration(milliseconds: 700));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => isOnline
            ? const BottomNavBar(userName: 'guest')


            : OfflineScreen(
                retry: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bgController,
      builder: (context, child) {
        final double wave = _bgController.value * 2 * math.pi;

        final Color color1 = Color.lerp(
          const Color(0xFF0D1B2A),
          const Color(0xFF1B263B),
          (0.5 + 0.5 * math.sin(wave)).clamp(0.0, 1.0),
        )!;

        final Color color2 = Color.lerp(
          const Color(0xFF1B263B),
          const Color(0xFF415A77),
          (0.5 + 0.5 * math.sin(wave + 1)).clamp(0.0, 1.0),
        )!;

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: _fadeText,
                    child: ScaleTransition(
                      scale: _scaleText,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.12),
                              blurRadius: 12,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        // Use a small width to force a smaller decode size
                        child: Image.asset(
                          'images/logo_transparent.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

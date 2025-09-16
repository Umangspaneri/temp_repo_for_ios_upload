import 'package:eqb_ltd/start.dart';
import 'package:flutter/material.dart';
// Make sure the path is correct

void main() {

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rentpedia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      // home: BottomNavBar(userName: 'guest',)
      home:SplashScreen(),
    );
  }
}
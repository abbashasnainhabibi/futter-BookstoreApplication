import 'package:bookstore/credentials/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Myonboardingsplashscreen extends StatefulWidget {
  const Myonboardingsplashscreen({super.key});

  @override
  State<Myonboardingsplashscreen> createState() => _MyonboardingsplashscreenState();
}

class _MyonboardingsplashscreenState extends State<Myonboardingsplashscreen> {
  @override
  void initState() {
    super.initState();
    NavigatePage();
  }

  NavigatePage() {
    Future.delayed(const Duration(seconds: 4), () =>
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => Mylogin())
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,  // Set background color to black
        body: Center(
          child: Lottie.asset('assets/images/animations/load2.json', height: 300),
        ),
      ),
    );
  }
}

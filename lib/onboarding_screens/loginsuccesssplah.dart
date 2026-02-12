
import 'package:bookstore/home.dart';
import 'package:bookstore/onboarding_screens/signupsuccess.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';





class Myloginsuccesssplash extends StatefulWidget {
  const Myloginsuccesssplash({super.key});


  @override
  State<Myloginsuccesssplash> createState() => _MyloginsuccesssplashState();
}


class _MyloginsuccesssplashState extends State<Myloginsuccesssplash> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    NavigatePage();
  }


  NavigatePage()
  {
   Future.delayed(Duration(seconds: 2), ()=>
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Myhome()))
   );
  }


  @override
  Widget build(BuildContext context) {
   return MaterialApp(
      debugShowCheckedModeBanner: false,
home: Scaffold(
  body: Center(
    
    child: Lottie.asset('assest/images/animatiosn/1.json', height: 300), ),
),
    );
  }
  
}
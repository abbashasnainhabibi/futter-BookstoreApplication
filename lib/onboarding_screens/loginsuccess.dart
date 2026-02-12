
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:bookstore/home.dart';



class Myloginsuccess extends StatefulWidget {
  const Myloginsuccess({super.key});

  @override
  State<Myloginsuccess> createState() => _MyloginsuccessState();
}

class _MyloginsuccessState extends State<Myloginsuccess> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    NavigatePage();
  }


  NavigatePage()
  {
   Future.delayed(const Duration(seconds: 1), ()=>
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Myhome()))
   );
  }

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
home: Scaffold(
  body: Center(
    
    child: Lottie.asset('assets/images/1.json', height: 300), ),
),
    );
  }
}
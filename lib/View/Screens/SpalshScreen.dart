import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/View/Screens/HomeScreen.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  static String id='SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Timer(Duration(seconds: 3), ()
    {
      Navigator.popAndPushNamed(context, HomeScreen.id);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.transparent,
            child: SvgPicture.asset('images/news1.svg',width: 110,height: 110,)),
      ),
    );
  }
}

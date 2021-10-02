import'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/Model/Provider/Country.dart';
import 'package:news/View/Screens/ArticleScreen.dart';
import 'package:news/View/Screens/CategoryScreen.dart';
import 'package:news/View/Screens/HomeScreen.dart';
import 'package:news/View/Screens/SpalshScreen.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>CountryPrv()),
      ],
      child: News()));
}
class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      builder:()=> MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {
          HomeScreen.id:(context)=>HomeScreen(),
          SplashScreen.id:(context)=>SplashScreen(),
          CategoryScreen.id:(context)=>CategoryScreen(),
          ArticleScreen.id:(context)=>ArticleScreen(),
        },
      ),
    );
  }
}
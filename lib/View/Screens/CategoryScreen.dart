import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/Model/Category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CategoryScreen extends StatelessWidget {
  static String id='CategoryScreen';
  CategoryModel? category;
  CategoryScreen({this.category});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 0.4.sh,color: Colors.black,
            child: Image(image: NetworkImage(category!.imagePath!),fit: BoxFit.fill,),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(category!.title!,style: GoogleFonts.share(fontSize: 35),),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/Controller/API_Helper.dart';
import 'package:news/Model/Category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/Model/article.dart';
class CategoryScreen extends StatefulWidget {
  static String id='CategoryScreen';
  CategoryModel? category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ArticleModel> categoryList=[];

  ApiHelper apiHelper=ApiHelper();

  getNewsCategory()
  {
    apiHelper.getNewsCategory().then((value)
    {
      setState(() {
        categoryList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 0.2.sh,
            child: Image(image: NetworkImage(widget.category!.imagePath!),fit: BoxFit.fill,),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(widget.category!.title!,style: GoogleFonts.share(fontSize: 35),),
          ),
          Expanded(child: ListView.builder(
            itemCount: categoryList.length,
              itemBuilder: (context,index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 0.4.sh,width: 1.sw,color: Colors.red,
                    decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              categoryList[index].urlImage==null?
                              'https://c0.wallpaperflare.com/preview/702/176/950/agenda-american-analytics-black-and-white-thumbnail.jpg'
                                  :
                              categoryList[index].urlImage!),)
                    ),
                    child: Column(
                      children: [
                        Text(categoryList[index].title!),
                      ],
                    ),
                  ),
                );
          }))
        ],
      ),
    );
  }
}

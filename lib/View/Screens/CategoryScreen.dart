import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/Controller/API_Helper.dart';
import 'package:news/Model/Category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/Model/article.dart';
import 'package:news/View/Screens/ArticleScreen.dart';
import 'package:shimmer/shimmer.dart';

class CategoryScreen extends StatefulWidget {
  static String id = 'CategoryScreen';
  CategoryModel? category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<ArticleModel> articles = [];
  ApiHelper apiHelper = ApiHelper();
  getCategoryNews() {
    apiHelper.getNewsCategory(widget.category!.categoryName!,context).then((v) {
      setState(() {
        articles = v;
      });
    });
  }

  @override
  initState() {
    super.initState();
    getCategoryNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        title: Row(
          children: [
            Text(
              widget.category!.categoryName!,
              style: GoogleFonts.jomolhari(
                  fontSize: 36.sp,
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.w600),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.transparent,
              child: Text(
                ' News',
                style: GoogleFonts.jomolhari(
                    fontSize: 29.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: ()
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context)
                              =>ArticleScreen(url: articles[index].url,)));
                            },
                            child: Container(
                              height: 0.35.sh,width: 1.sw,
                              decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        articles[index].urlToImage==null?
                                        'https://c0.wallpaperflare.com/preview/702/176/950/agenda-american-analytics-black-and-white-thumbnail.jpg'
                                            :
                                        articles[index].urlToImage!),)
                              ),
                            ),
                          ),
                          Container(
                            height: 85.h,width: double.infinity.sw,color: Colors.transparent,
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text(articles[index].title!,style: GoogleFonts.jomolhari(fontSize: 13,fontWeight: FontWeight.w800),),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 9,right: 5),
                                          child: Text(articles[index].publishedAt!,style: GoogleFonts.jomolhari(fontSize: 13,fontWeight: FontWeight.w800),),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

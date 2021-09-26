import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/Controller/API_Helper.dart';
import 'package:news/Model/Category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/Model/article.dart';
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
    apiHelper.getNewsCategory(widget.category!.categoryName!).then((v) {
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              widget.category!.categoryName!,
              style: GoogleFonts.rubik(
                  fontSize: 37.sp,
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.w500),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.transparent,
              child: Text(
                ' News',
                style: GoogleFonts.play(
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
                      child: Container(
                        height: 0.4.sh,
                        width: 1.sw,
                        decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(articles[index].urlToImage ==
                                      null
                                  ? 'https://c0.wallpaperflare.com/preview/702/176/950/agenda-american-analytics-black-and-white-thumbnail.jpg'
                                  : articles[index].urlToImage!),
                            )),
                        child: Column(
                          children: [
                            Text(articles[index].title!),
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

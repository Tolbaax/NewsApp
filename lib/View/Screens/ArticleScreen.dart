import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticleScreen extends StatelessWidget {
  static String id='ArticleScreen';
  String? url;
  ArticleScreen({this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Shimmer.fromColors(
            baseColor: Colors.grey.shade900,
            highlightColor: Colors.red,
            child: Text("World News",style: GoogleFonts.jomolhari(color: Colors.black,fontSize: 33,fontWeight: FontWeight.w900),)),
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}

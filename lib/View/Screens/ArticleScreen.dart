import 'package:flutter/material.dart';
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
        title: Text('World News',style: TextStyle(color: Colors.black,fontSize: 25,),),
      ),
      body: WebView(
        initialUrl: (url),
      ),
    );
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news/Model/article.dart';

class ApiHelper{

  getNews()async
  {
    List<ArticleModel>articles=[];
    var response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=Eg&apiKey=330ca0aaad2142668cb50d692a5afeb7'));
    var body = jsonDecode(response.body);

    if(body['status']== 'ok')
    {
      body["articles"].forEach((element)
      {
        ArticleModel article =ArticleModel(
          title: element["title"],
          author: element["author"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          publishedAt: element["publishedAt"],
        );
        articles.add(article);
      });
    }
    else
    {
      print('No Data');
    }
    return articles;
  }

  getNewsCategory(categoryName)async
  {
    List<ArticleModel>articles=[];
    var response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=$categoryName&apiKey=8a3cbe6943ad4a9c8aa85c0bd0cbbaa7'));
    var body = jsonDecode(response.body);
    if(body['status']== 'ok')
    {
      body["articles"].forEach((element)
      {
        ArticleModel article =ArticleModel(
          title: element["title"],
          author: element["author"],
          description: element["description"],
          url: element["url"],
          urlToImage: element["urlToImage"],
          publishedAt: element["publishedAt"],
        );
        articles.add(article);
      });
    }
    else
    {
      print('No Data');
    }
    return articles;
  }
}
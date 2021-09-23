import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/Model/article.dart';

class ApiHelper{

  getNews()async
  {
    List<Article>articles=[];
    var response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=eg&apiKey=330ca0aaad2142668cb50d692a5afeb7'));
    var body = jsonDecode(response.body);

    if(body['status']== 'ok')
      {
        body["articles"].forEach((element)
        {
          Article article =Article(
            title: element["title"],
            author: element["author"],
            desc: element["description"],
            url: element["url"],
            urlImage: element["urlToImage"],
            publishedAt: element["publishedAt"],
            content: element["content"],
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

  getNewsCategory()
  {

  }
}
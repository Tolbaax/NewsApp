import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/Controller/API_Helper.dart';
import 'package:news/Model/Category.dart';
import 'package:news/Model/Provider/Country.dart';
import 'package:news/Model/article.dart';
import 'package:news/View/Screens/ArticleScreen.dart';
import 'package:news/View/Screens/CategoryScreen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class HomeScreen extends StatefulWidget {
  static String id ='HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> category=[
    CategoryModel(categoryName: 'General',imagePath: 'https://i.guim.co.uk/img/media/3bf13aa96597041e2e1f68cfca85e2ca88f6d03c/0_186_5512_3308/master/5512.jpg?width=445&quality=45&auto=format&fit=max&dpr=2&s=2d83f340e8389118873611688dd45323'),
    CategoryModel(categoryName: 'Technology',imagePath: 'https://www.globalfocusmagazine.com/wp-content/uploads/2020/02/Engaging_with_technology-scaled.jpg'),
    CategoryModel(categoryName: 'Sports',imagePath: 'https://pbs.twimg.com/media/EjubLbzWsAAm-bf.jpg'),
    CategoryModel(categoryName: 'Business',imagePath: 'https://c0.wallpaperflare.com/preview/702/176/950/agenda-american-analytics-black-and-white-thumbnail.jpg'),
    CategoryModel(categoryName: 'Science',imagePath: 'https://assets.weforum.org/community/image/3v8PB95CCSn86e5fowthRAybW4ajSY18z2FfVPi2spk.jpeg'),
    CategoryModel(categoryName: 'Health',imagePath: 'https://www.eehealth.org/-/media/images/modules/blog/posts/2019/08/workout-in-gym.jpg'),
  ];

  bool isConnected=false;
  StreamSubscription? ConnectMethod;
  Connectivity connect=Connectivity();
  List<ArticleModel> homeList=[];
  ApiHelper apiHelper=ApiHelper();

  getNews()
  {
    apiHelper.getNews(context).then((v)
    {
      setState(() {
        homeList = v;
      });
    }
    );
  }
  @override
  initState() {
    super.initState();
    getNews();
    ConnectMethod = connect.onConnectivityChanged.listen((result) {
      if(result !=ConnectivityResult.none)
      {
        setState(() {
          isConnected=true;
        });
      }
    });
  }
  @override
  dispose() {
    super.dispose();
    ConnectMethod!.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.red.shade900,
      //   child:Icon(Icons.search,size: 27,),
      //   onPressed: (){},
      // ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text('     WORLD',style:
            GoogleFonts.jomolhari(fontSize: 36.sp,color: Colors.red.shade900,fontWeight: FontWeight.w600),),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.transparent,
              child: Text(' News',style:
              GoogleFonts.jomolhari(fontSize: 29.sp,color: Colors.grey,fontWeight: FontWeight.w600),),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(1.sw,50.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CountryCodePicker(
                initialSelection: 'Eg',
                showCountryOnly: true,
                showOnlyCountryWhenClosed: true,
                onChanged: (value)
                {
                  Provider.of<CountryPrv>(context,listen: false).countryChange(value.code);
                  getNews();
                },
              ),
            ],
          ),
        ),
      ),
      body:
      !isConnected?Center(child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off,size: 55.sp,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('No internet',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
          ),
        ],
      )):
      Column(
        children: [
          Container(
            height: 150.h,width: 1.sw,
            child: ListView.builder(
                itemCount: category.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        =>CategoryScreen(category: category[index],)));
                      },
                      child: Container(
                        width: 0.6.sw,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(category[index].imagePath!),
                                fit: BoxFit.fill
                            ),
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 25),
                              child: Text(category[index].categoryName!,style:
                              GoogleFonts.jomolhari(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w500),),
                            )),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: homeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)
                            =>ArticleScreen(url: homeList[index].url,)));
                          },
                          child: Container(
                            height: 0.35.sh,width: 1.sw,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      homeList[index].urlToImage==null?
                                      'https://www.globalfocusmagazine.com/wp-content/uploads/2020/02/Engaging_with_technology-scaled.jpg'
                                          :
                                      homeList[index].urlToImage!),)
                            ),
                          ),
                        ),
                        Container(
                          height: 85.h,width: double.infinity.sw,color: Colors.transparent,
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(homeList[index].title!,style: GoogleFonts.jomolhari(fontSize: 13,fontWeight: FontWeight.w700),),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 9,right: 5),
                                        child: Text(homeList[index].publishedAt!,style: GoogleFonts.jomolhari(fontSize: 13,fontWeight: FontWeight.w800),),
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
    );
  }
}
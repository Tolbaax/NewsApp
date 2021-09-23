import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/Controller/API_Helper.dart';
import 'package:news/Model/Category.dart';
import 'package:news/Model/article.dart';
import 'package:news/View/Screens/CategoryScreen.dart';
import 'package:shimmer/shimmer.dart';
class HomeScreen extends StatefulWidget {
  static String id ='HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> category=[
    CategoryModel(title: 'Local',imagePath: 'https://i.guim.co.uk/img/media/3bf13aa96597041e2e1f68cfca85e2ca88f6d03c/0_186_5512_3308/master/5512.jpg?width=445&quality=45&auto=format&fit=max&dpr=2&s=2d83f340e8389118873611688dd45323'),
    CategoryModel(title: 'Sports',imagePath: 'https://pbs.twimg.com/media/EjubLbzWsAAm-bf.jpg'),
    CategoryModel(title: 'Business',imagePath: 'https://c0.wallpaperflare.com/preview/702/176/950/agenda-american-analytics-black-and-white-thumbnail.jpg'),
    CategoryModel(title: 'Environment',imagePath: 'https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247632.jpg'),
    CategoryModel(title: 'Politics',imagePath: 'https://www.vicenzapiu.com/wp-content/uploads/2020/12/politica.jpg'),
    CategoryModel(title: 'LifeStyle',imagePath: 'https://www.eehealth.org/-/media/images/modules/blog/posts/2019/08/workout-in-gym.jpg'),
  ];

  bool isConnected=false;
  StreamSubscription? ConnectMethod;
  Connectivity connect=Connectivity();
  List<ArticleModel> homeList=[];
  ApiHelper apiHelper=ApiHelper();

  getNews()
  {
    apiHelper.getNews().then((v)
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade900,
        child:Icon(Icons.search,size: 27,),
        onPressed: (){},
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text('     WORLD',style:
            GoogleFonts.rubik(fontSize: 37.sp,color: Colors.red.shade900,fontWeight: FontWeight.w500),),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade800,
              highlightColor: Colors.transparent,
              child: Text(' News',style:
              GoogleFonts.play(fontSize: 29.sp,color: Colors.grey,fontWeight: FontWeight.w600),),
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
                              child: Text(category[index].title!,style:
                              GoogleFonts.share(fontSize: 35,color: Colors.white,fontWeight: FontWeight.w500),),
                            )),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: ListView.builder(
              itemCount: homeList.length,
              itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 0.4.sh,width: 1.sw,
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        homeList[index].urlImage==null?
                        'https://c0.wallpaperflare.com/preview/702/176/950/agenda-american-analytics-black-and-white-thumbnail.jpg'
                            :
                        homeList[index].urlImage!),)
                ),
                child: Column(
                  children: [
                    Text(homeList[index].title!),
                  ],
                ),
              ),
            );

          }),)
        ],
      ),
    );
  }
}



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../Api/Apis.dart';
import '../Pages/Pages.dart';
import '../main.dart';
import '../Entities/Entities.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<RecipeEntity> recipes = [];

  void initState() {
    super.initState();
    print("initState in profile page");
    WidgetsBinding.instance!.addPostFrameCallback((_) => getUserRecipes(context));
  }

  void getUserRecipes(context) async{

    String url = Apis.baseApi + Apis.recipeSearch;
    var dio = Dio();
    var response = await dio.post(
      url,
      data: FormData.fromMap({
        'userId': 9,
      }),
    );
    print("RecipeEntity response");
    print(response);

    final Map<String, dynamic> parsed = json.decode(response.toString());
    if(parsed['data'][0]['userDefinedRecipeId'] != null){

      RecipeSearchResponse result = RecipeSearchResponse.fromJson(parsed);

      setState(() {
        recipes = result.data;
      });
    }
    else{
      setState(() {
        recipes = [];
      });
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 220, 130, 1),
        leading: Container(),
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32,horizontal: 16),
            child: Row(
              children: [
                Text(
                  greeting(),
                  style: TextStyle(
                      fontSize: 48,
                      color: Colors.black87,
                      fontFamily: "Balimoon",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              height: 400,
              child: Swiper(
                itemBuilder: (BuildContext context,int index){

                  if(index == 0){
                    return swiperItem("assets/images/images.jpg", index, 1);
                  }
                  else if(index == 1){
                    return swiperItem("assets/images/image.jpg", index, 3);
                  }
                  else if(index == 2){
                    return swiperItem("assets/images/healthy+food+vertical.png", index, 4);
                  }
                  else if(index == 3){
                    return swiperItem("assets/images/37558132-healthy-food-granola-fresh-berries-and-milk-vertical-close-up.jpg", index, 2);
                  }
                  else{
                    return swiperItem("assets/images/FkVsO6LcJ5LUGgSt.jpg", index, 5);
                  }
                },
                itemCount: 5,
              ),
            )
          ),
          Container(height: 32,),

        ],
      )

    );
  }

  Widget swiperItem(String url, int index, int id){
    return GestureDetector(
      onTap: ()async{
        print("recipe id: ");
        print(id);
        print(recipes[id-1]);

        var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => SingleRecipePage(
          recipe: recipes[id-1],
        )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.elliptical(40, 40),
            ),
            image: DecorationImage(
              image: AssetImage(
                url,
              ),
              fit: BoxFit.cover,
            )
        ),
      ),
    );

  }
}



import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:untitled/main.dart';

import '../Api/Apis.dart';
import '../Entities/Entities.dart';
import 'RecipesPage.dart';


class ProfilePage extends StatefulWidget {
  final bool isLogin;

  ProfilePage({
    Key? key,
    this.isLogin = false,

  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  ScrollController _scrollController = ScrollController();
  List<RecipeEntity> recipes = [];
  String settingText = "Setting";

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
        'userId': MyApp.userId,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 220, 130, 1),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80,left: 32,right: 32, bottom: 40),
            child: Container(
              height: 120,
              // color: Colors.red,
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/user-member-avatar-face-profile-icon-vector-22965342.jpg"
                        ),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: GestureDetector(
                      onTap: (){
                        print("setting");
                      },
                      child: Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black45,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(20, 20),
                          ),
                          color: Colors.black12,
                        ),
                        child: Center(
                          child: Text(
                            settingText,
                            style: TextStyle(

                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black45
              ),
              color: Colors.white70
            ),
            child: Center(
              child: Text(
                "* Your Recipes *",
                style: TextStyle(
                  fontSize: 20
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white70,
              child: StaggeredGridView.countBuilder(
                itemCount: recipes.length,
                controller: _scrollController,
                crossAxisCount: 2,
                itemBuilder: (context, index) => recipeWidget(index, recipes[index].recipeDescription),
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            )
          )
        ],
      )
    );
  }

  Widget recipeWidget(int index, String title){
    return Card(
      elevation: 0,
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
          onTap: ()async{
            var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => SingleRecipePage(
              recipe: recipes[index],
              isOwn: true,
            )));
            if(result != null){
              getUserRecipes(context);
            }
          },
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/cobb-salad-18.jpg",
                        ),
                        fit:BoxFit.cover
                      )
                    ),
                  ),
                ),

                //post title
                Container(
                    height: MediaQuery.of(context).size.shortestSide * 0.08,
                    padding: EdgeInsets.only(left: 8, bottom: 1),
                    child: Row(
                        children: <Widget> [
                          Expanded(
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto Medium',
                                  // fontWeight: FontWeight.bold
                                ),
                              )
                          )
                        ]
                    )
                ),

              ]
          )
      ),
    );
  }
}
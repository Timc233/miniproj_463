

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Entities/Entities.dart';


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
  List<RecipeFoodEntity> recipes = [];
  String settingText = "Setting";

  void initState() {
    super.initState();
    print("initState in profile page");
    WidgetsBinding.instance!.addPostFrameCallback((_) => getUserRecipes(context));
  }

  void getUserRecipes(context) async{
    setState(() {
      settingText = "Guess what";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      color: Colors.grey
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
              )
            ),
            child: Center(
              child: Text(
                "Your Recipes",
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
              color: Color.fromRGBO(256, 256, 256, 0.05),
              child: StaggeredGridView.countBuilder(
                itemCount: recipes.length,
                controller: _scrollController,
                crossAxisCount: 2,
                itemBuilder: (context, index) => recipeWidget(recipes[index].foodName),
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            )
          )
        ],
      )
    );
  }

  Widget recipeWidget(String title){
    return Card(
      elevation: 0,
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
          onTap: (){
          },
          child: Column(
              children: [
                Stack(
                    children: <Widget>[
                      //image
                      Container(
                        height: 160,
                        color: Color.fromRGBO(244, 220, 130, 1),
                      )
                    ]
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
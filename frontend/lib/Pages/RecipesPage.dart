

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Entities/Entities.dart';
import '../main.dart';
import '../Api/Apis.dart';

class RecipesPage extends StatefulWidget {

  int amount;
  String barcode;
  List<RecipeEntity> recipes;

  RecipesPage({
    Key? key,
    this.amount = 0,
    this.barcode = "",
    required this.recipes,
  }) : super(key: key);

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {

  ScrollController _scrollController = ScrollController();

  String newName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 220, 130, 1),
        centerTitle: true,
        title: Text(
          "Recipes List",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(4),
        color: Colors.white,
        child: Container(
          color: Color.fromRGBO(256, 256, 256, 0.05),
          child: StaggeredGridView.countBuilder(
            itemCount: widget.recipes.length,
            controller: _scrollController,
            crossAxisCount: 2,
            itemBuilder: (BuildContext context,int index){
              if(index == 0){
                return Card(
                  elevation: 0,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: InkWell(
                      onTap: (){

                        addToRecipe(index);

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
                                  color: Color.fromRGBO(244, 220, 130, 1),
                                ),
                                child: Center(
                                  child: Text(
                                    "New"
                                  ),
                                ),
                              ),
                            ),

                          ]
                      )
                  ),
                );
              }
              else{
                return recipeWidget(index, widget.recipes[index].recipeDescription);
              }
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
          ),
        ),
      ),
    );
  }

  void addToRecipe(int index)async{
    print("addToRecipe");
    String url = Apis.baseApi + Apis.recipeAddFood;

    var dio = Dio();
    var response = await dio.post(
      url,
      data: (index == 0)?FormData.fromMap({
        'userId': MyApp.userId,
        'foodIndex': widget.barcode,
        'recipeDescription': newName,
        'amount': widget.amount,
      })
          :FormData.fromMap({
        'userId': MyApp.userId,
        'foodIndex': widget.barcode,
        'recipeId': widget.recipes[index].userDefinedRecipeId,
        'recipeDescription': newName,
        'amount': widget.amount,
      }),
    );
    print("addToRecipe response");
    print(response);


    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget recipeWidget(int index, String title){
    return Card(
      elevation: 0,
      color: Colors.white70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
          onTap: (){

            addToRecipe(index);

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
                      color: Color.fromRGBO(244, 220, 130, 1),
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


class SingleRecipePage extends StatefulWidget {

  String barcode;
  RecipeEntity recipe;

  SingleRecipePage({
    Key? key,
    this.barcode = "",
    required this.recipe,
  }) : super(key: key);

  @override
  _SingleRecipesPageState createState() => _SingleRecipesPageState();
}

class _SingleRecipesPageState extends State<SingleRecipePage> {

  void initState(){
    super.initState();

    print(widget.recipe.userDefinedRecipeId);
    print(widget.recipe.recipeDescription);
    print("totalCalories: " + widget.recipe.totalCalories.toString());
    print("foods.length: " + widget.recipe.foods.length.toString());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 220, 130, 1),
        centerTitle: true,
        title: Text(
          widget.recipe.recipeDescription,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Container(
                height: 80,
                child: Center(
                  child: Text(
                    widget.recipe.totalCalories.roundToDouble().toString() + " cal",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              child: SingleChildScrollView(
                child: Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: widget.recipe.foods.length,
                      itemBuilder: (BuildContext context,int index){
                        return ListTile(
                            leading: Icon(Icons.food_bank_rounded),
                            trailing: Text(
                              widget.recipe.foods[index].caloriePerServing.roundToDouble().toString() + "\ncalorie/serving",
                              style: TextStyle(
                                  color: Colors.green,fontSize: 15
                              ),
                              textAlign: TextAlign.center,
                            ),
                            title:Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(widget.recipe.foods[index].foodName),

                            )
                        );
                      }
                  ),
                )
              ),

            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}




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

  final FocusNode focusNode = FocusNode();

  TextEditingController _recipeInfoController = TextEditingController();

  bool isLoading = false;

  void initState() {
    super.initState();
    print("initState in Recipes page");
  }

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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(4),
            color: Colors.white,
            child: Container(
              color: Color.fromRGBO(256, 256, 256, 0.05),
              child: StaggeredGridView.countBuilder(
                itemCount: widget.recipes.length+1,
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
                            enterRecipeInfo(index);

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
                    return recipeWidget(index, widget.recipes[index-1].recipeDescription);
                  }
                },
                staggeredTileBuilder: (index) => StaggeredTile.fit(1),
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        ],
      )
    );
  }

  void addToRecipe(int index)async{
    print("addToRecipe");
    print(MyApp.userId);
    print(widget.barcode);
    print(_recipeInfoController.text);
    print(widget.amount);
    String url = Apis.baseApi + Apis.recipeAddFood;
    setState(() {
      isLoading = true;
    });

    var dio = Dio();
    var response = await dio.post(
      url,
      data: (index == 0)?FormData.fromMap({
        'userId': MyApp.userId,
        'foodIndex': widget.barcode,
        'recipeId': "",
        'recipeDescription': _recipeInfoController.text,
        'amount': widget.amount,
      })
          :FormData.fromMap({
        'userId': MyApp.userId,
        'foodIndex': widget.barcode,
        'recipeId': widget.recipes[index-1].userDefinedRecipeId,
        'recipeDescription': _recipeInfoController.text,
        'amount': widget.amount,
      }),
    );
    print("addToRecipe response");
    print(response);

    setState(() {
      isLoading = false;
    });

    if(response.statusCode == 200){

      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void enterRecipeInfo(int index){
    if(index != 0){
      setState(() {
        _recipeInfoController.text = widget.recipes[index-1].recipeDescription;
      });
    }
    else{
      setState(() {
        _recipeInfoController.text = "new Recipe";
      });
    }
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        content: Stack(
          children: [
            Container(
                width: MediaQuery.of(context).size.shortestSide * 0.7893,
                child: Form(
                    child: TextField(
                      focusNode: focusNode,
                      controller: _recipeInfoController,
                      style: TextStyle(fontSize: 12, ),
                      decoration:  InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        helperText: ' ',
                        filled: true,
                        contentPadding: EdgeInsets.only(left: 15, top: 5),
                        hintText: "Enter Your Recipe Description",
                        suffixIcon: IconButton(
                          onPressed: _recipeInfoController.clear,
                          icon: Icon(Icons.clear, color: Colors.black),
                        ),
                      ),
                      autofocus: false,
                      onSubmitted: (value) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    )
                )
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                addToRecipe(index);
                Navigator.pop(context);
              },
              child: Text('Confirm')
          ),
          // TextButton(
          //   onPressed: () {
          //     print('Add to Recipe!');
          //
          //     if(MyApp.isLogin){
          //       getRecipes(barcode);
          //     }
          //     else{
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSigninPage()));
          //     }
          //   },
          //   child: Text('Add to Recipe'),
          // ),
          TextButton(
            onPressed: () {
              print('Close!');
              Navigator.pop(context);
            },
            child: Text('Close'),
          )
        ],
      );
    });
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
            enterRecipeInfo(index);

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

  void deleteRecipe()async{
    print("deleteRecipe");
    print(MyApp.userId);
    print(widget.recipe.userDefinedRecipeId);
    String url = Apis.baseApi + Apis.recipeDelete;
    var dio = Dio();
    var response = await dio.post(
      url,
      data: FormData.fromMap({
        'userId': MyApp.userId,
        'userDefinedRecipeId': widget.recipe.userDefinedRecipeId,
      }),
    );
    print("deleteRecipe response");
    print(response);

    Navigator.pop(context, "delete");
  }

  void deleteFood(int index)async{
    String url = Apis.baseApi + Apis.foodDelete;
    var dio = Dio();
    var response = await dio.post(
      url,
      data: FormData.fromMap({
        'userId': MyApp.userId,
        'recipeId': widget.recipe.foods[index].recipeId,
      }),
    );
    print("deleteRecipe response");
    print(response);

    setState(() {

      widget.recipe.foods.removeAt(index);
    });
    if(widget.recipe.foods.isEmpty){
      Navigator.pop(context, "delete");
    }


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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: (){
                deleteRecipe();
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          )
        ],
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
                            leading: GestureDetector(
                              onTap: (){
                                deleteFood(index);
                              },
                              child: Icon(Icons.delete_outline),
                            ),
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


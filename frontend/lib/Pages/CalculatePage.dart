

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Api/Apis.dart';
import 'package:untitled/Pages/RecipesPage.dart';

import '../Entities/Entities.dart';
import '../main.dart';
import 'Pages.dart';

class CalculatePage extends StatefulWidget {
  CalculatePage({
    Key? key,
  }) : super(key: key);

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {

  int barcode = -1;
  bool isLoading = false;

  void scanBarcodeAction() async{
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    print("barcodeScanRes");
    print(barcodeScanRes);
    if(barcodeScanRes != "-1"){
      uploadBarcodeAction(barcodeScanRes);
    }
  }

  void uploadBarcodeAction(String barcode)async{

    print("uploadBarcodeAction");
    String url = Apis.baseApi + Apis.searchBarcode;
    url = url + barcode;

    try {
      var dio = Dio();
      var response = await dio.get(url);
      print("barcode response");
      print(response);

      final Map<String, dynamic> parsed = json.decode(response.toString());
      FoodSearchResponse result = FoodSearchResponse.fromJson(parsed);

      print("result");
      print(result);
      print(result.responseCode);
      print(result.message);
      print(result.data.foodName);
      print(result.data.caloriesPerServing);
      
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Stack(
            children: [
              Container(
                height: 80,
                width: 200,
                child: Center(
                  child: Text(result.data.foodName),
                ),
              ),
              Visibility(
                visible: isLoading,
                child: CircularProgressIndicator(),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                getFoodDetail(barcode);
              },
              child: Text('Detail')
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

    } catch (e) {
      print(e);
    }

  }

  void getFoodDetail(String barcode)async{
    setState(() {
      isLoading = true;
    });
    String url = Apis.baseApi + Apis.searchFoodDetail;
    url = url + barcode;

    var dio = Dio();
    var response = await dio.get(url);
    print("food detail response");
    print(url);
    print(response);

    final Map<String, dynamic> parsed = json.decode(response.toString());
    FoodDetailSearchResponse result = FoodDetailSearchResponse.fromJson(parsed);

    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(
      foodDetail: result.data,
      barcode: barcode,
    )));
    setState(() {
      isLoading = false;
    });

  }

  void getRecipes(String barcode)async{
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
    RecipeSearchResponse result = RecipeSearchResponse.fromJson(parsed);

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecipesPage(
          barcode: barcode,
          recipes: result.data,
        )
      )
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(244, 220, 130, 1),
        child: Center(
          child: GestureDetector(
            onTap: (){
              scanBarcodeAction();

              // uploadBarcodeAction(barcode);
            },
            child: Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.elliptical(20, 20),
                ),
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  "Pick a Barcode",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
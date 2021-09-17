

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

class ScanPage extends StatefulWidget {
  ScanPage({
    Key? key,
  }) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  int barcode = -1;
  bool isLoading = false;

  final FocusNode focusNode = FocusNode();

  TextEditingController _barcodeController = TextEditingController();

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

      if(parsed['responseCode'] == 200){
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
      }
      else{
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Stack(
              children: [
                Container(
                  height: 40,
                  width: 200,
                  child: Center(
                    child: Text("Food not found"),
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
                  print('Close!');
                  Navigator.pop(context);
                },
                child: Text('Close'),
              )
            ],
          );
        });
      }


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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(244, 220, 130, 1),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Spacer(flex: 6,),

            GestureDetector(
              onTap: (){
                scanBarcodeAction();

                // uploadBarcodeAction(barcode);
              },
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(200, 200),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.black87,
                    size: 100,
                  )
                ),
              ),
            ),
            Spacer(flex: 2,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                  child: TextField(
                    focusNode: focusNode,
                    controller: _barcodeController,
                    style: TextStyle(fontSize: 12, ),
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      helperText: ' ',
                      filled: true,
                      contentPadding: EdgeInsets.only(left: 15, top: 5),
                      hintText: "Enter a Barcode",
                      suffixIcon: IconButton(
                        onPressed: _barcodeController.clear,
                        icon: Icon(Icons.clear, color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    onSubmitted: (value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(value.isNotEmpty){
                        uploadBarcodeAction(value);
                      }
                    },
                  )
              ),
            ),

            Spacer(flex: 4,),
          ],
        )
      ),
    );
  }
}


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Api/Apis.dart';

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

  int barcode = 894700010069;

  void scanBarcodeAction() async{
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    print("barcodeScanRes");
    print(barcodeScanRes);
    uploadBarcodeAction(barcodeScanRes);
  }

  void uploadBarcodeAction(String barcode)async{

    print("uploadBarcodeAction");
    String url = Apis.baseApi + Apis.searchBarcode; // Api here ignored
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

    } catch (e) {
      print(e);
    }

    // var url = Uri.parse('http://ec2-18-212-8-137.compute-1.amazonaws.com:10086/food/search?barcode=894700010069');
    // var response = await http.get(url);
    // print("barcode response");
    // print(response);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(244, 220, 130, 1),
        child: Center(
          child: GestureDetector(
            onTap: (){
              if(MyApp.isLogin){
                scanBarcodeAction();
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSigninPage()));
              }

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
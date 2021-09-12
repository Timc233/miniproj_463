

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Api/Apis.dart';

import '../Entities/Entities.dart';

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
  }

  void uploadBarcodeAction(int barcode)async{

    print("uploadBarcodeAction");
    String url = Apis.api + "/food/search?barcode="; // Api here ignored
    url = url + barcode.toString();

    try {
      var dio = Dio();
      var response = await dio.get(url);
      print("barcode response");
      print(response);

      final Map<String, dynamic> parsed = json.decode(response.toString());
      FoodResponse result = FoodResponse.fromJson(parsed);

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
        color: Colors.green,
        child: Center(
          child: GestureDetector(
            onTap: (){
              scanBarcodeAction();
              // uploadBarcodeAction(barcode);
            },
            child: Container(
              height: 60,
              width: 120,
              color: Colors.white,
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

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/Apis.dart';
import '../Pages/Pages.dart';
import '../Entities/Entities.dart';
import '../main.dart';

class FoodDetailPage extends StatefulWidget {
  FoodDetailEntity? foodDetail;
  String barcode;
  FoodDetailPage({
    Key? key,
    this.foodDetail,
    this.barcode = "",
  }) : super(key: key);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {

  //数据源 下标  表示当前是PieData哪个对象
  int subscript = 0;
  List<PieData> mData = [];
  PieData pieData = PieData();
  //当前选中
  var currentSelect = 0;

  int amountNum = 1;

  @override
  void initState() {
    super.initState();
    initData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 220, 130, 1),
      ),
      body: _graphWidget(),
    );
  }

  Widget _graphWidget() {
    return  Container(
      color: Colors.white54,
      child: Padding(
        padding: EdgeInsets.all(50),
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              height: 30,
              child: Center(
                child: Text(
                  widget.foodDetail!.foodName,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ),

            ),
            Container(
              height: 300,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon:  Icon(Icons.arrow_left),
                        color: Colors.green[500],
                        onPressed: _left,
                        iconSize: 48,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 90.0,
                        height: 90.0,
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child:  MyCustomCircle(mData, pieData, currentSelect),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon:  Icon(Icons.arrow_right),
                        color: Colors.green[500],
                        onPressed: _right,
                        iconSize: 48,
                      ),
                    ],
                  ),
//
                ],
              ),
            ),
            Container(
              height: 30,
              child: Center(
                child: Text(
                  mData[currentSelect].content.Attribute,
                  style: TextStyle(
                    fontSize: 20,
                    color: mData[currentSelect].color
                  ),

                ),
              ),

            ),
            Container(
              height: 20,
              child: Center(
                child: Text(
                  "servingSize: "+ widget.foodDetail!.servingSize.toString() + " " + widget.foodDetail!.servingSizeUnit.toString(),
                  style: TextStyle(
                      fontSize: 14,
                  ),

                ),
              ),

            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              height: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(40, 40),
                        ),

                      ),
                      child: IconButton(
                        icon: Icon(
                            Icons.exposure_minus_1
                        ),
                        onPressed: (){
                          if(amountNum > 0){
                            setState(() {

                              amountNum --;
                            });
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(
                        child: Text(
                          amountNum.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.all(
                          Radius.elliptical(40, 40),
                        ),

                      ),
                      child: IconButton(
                        icon: Icon(
                            Icons.exposure_plus_1
                        ),
                        onPressed: (){
                          setState(() {
                            amountNum ++;
                          });
                        },
                      ),
                    ),

                  ],
                )
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 32),
              height: 60,
              child: Center(
                child: GestureDetector(
                  onTap: (){
                    print("Add to Recipe");
                    if(MyApp.isLogin){
                      getRecipes(widget.barcode);
                    }
                    else{
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSigninPage()));
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.elliptical(20, 20),
                      ),
                      color: Color.fromRGBO(244, 220, 130, 1),
                    ),
                    child: Center(
                      child: Text(
                        "Add to Recipe",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )

              ),
            )
          ],
        ),
      )
    );
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
    print(parsed['data'][0]['userDefinedRecipeId']);
    if(parsed['data'][0]['userDefinedRecipeId'] != null){

      RecipeSearchResponse result = RecipeSearchResponse.fromJson(parsed);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipesPage(
                amount: amountNum,
                barcode: barcode,
                recipes: result.data,
              )
          )
      );
    }
    else{
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipesPage(
                amount: amountNum,
                barcode: barcode,
                recipes: [],
              )
          )
      );
    }


  }

  void _left() {
    setState(() {

      subscript--;

      subscript = subscript % mData.length;
      currentSelect = subscript;

      pieData = mData[subscript];
    });
    print("left");
    print("currentSelect: " + currentSelect.toString());
  }

  void _right() {
    setState(() {

      subscript++;

      subscript = subscript % mData.length;
      currentSelect = subscript;

      pieData = mData[subscript];
    });
    print("right");
    print("currentSelect: " + currentSelect.toString());
  }

  void initData() {
    double totalNum = 0;
    mData = [];
    for(int i = 0; i < widget.foodDetail!.nutrients.length; i++){
      totalNum += widget.foodDetail!.nutrients[i].Value;
    }
    print("totalNum");
    print(totalNum);
    for(int i = 0; i < widget.foodDetail!.nutrients.length; i++){
      PieData p1 = new PieData();
      p1.content = widget.foodDetail!.nutrients[i];
      p1.percentage = widget.foodDetail!.nutrients[i].Value / totalNum;
      p1.color = Color.fromARGB(255, Random().nextInt(256)+0, Random().nextInt(256)+0, Random().nextInt(256)+0);
      if(p1.percentage != 0){
        mData.add(p1);
        print("nutrients:" + i.toString());
        print(p1.content);
      }
    }

    pieData = mData[0];
  }
}

class MyCustomCircle extends StatelessWidget{

  List<PieData> datas;
  PieData data;
  var dataSize;
  var currentSelect;

  MyCustomCircle(this.datas,this.data,this.currentSelect);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: MyView(datas,data,currentSelect,true)
    );
  }

}

class PieData{
  NutrientsEntity content = NutrientsEntity();
  Color color = Colors.transparent;
  double percentage = 0;

}

class MyView extends CustomPainter{

  var text = "";
  bool isChange=false;
  var currentSelect=0;
  Paint _mPaint = Paint();
  Paint TextPaint = Paint();
  int mWidth = 0, mHeight = 0;
  double mRadius = 0, mInnerRadius = 0,mBigRadius = 0;
  double mStartAngle = 0;
  Rect mOval = Rect.zero,mBigOval = Rect.zero;
  List<PieData> mData;
  PieData pieData;

  MyView(
      this.mData,
      this.pieData,
      this.currentSelect,
      this.isChange);
  @override
  void paint(Canvas canvas, Size size) {

    _mPaint = new Paint();
    TextPaint = new Paint();
    mHeight=100;
    mWidth=100;

    TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    TextPainter _newVerticalAxisTextPainter(String text) {
      return textPainter
        ..text = TextSpan(
          text: text,
          style: new TextStyle(
            color: Colors.black,
            fontSize: 10.0,
          ),
        );
    }

    mRadius = 50.0;

    mBigRadius=55.0;

    mInnerRadius = mRadius * 0.50;

    mOval = Rect.fromLTRB(-mRadius, -mRadius, mRadius, mRadius);

    mBigOval = Rect.fromLTRB(-mBigRadius, -mBigRadius, mBigRadius,mBigRadius);
    if (mData.length == null || mData.length <= 0) {
      return;
    }
    canvas.save();
    canvas.translate(50.0, 50.0);
    double startAngle = 0.0;
    for (int i = 0; i < mData.length; i++) {

      PieData p = mData[i];
      double hudu=p.percentage;
      double sweepAngle = 2*pi*hudu;
      _mPaint..color = p.color;
      if(currentSelect>=0 && i==currentSelect){
        canvas.drawArc(mBigOval, startAngle, sweepAngle, true, _mPaint);
      }
      else{
        canvas.drawArc(mOval, startAngle, sweepAngle, true, _mPaint);
      }
      startAngle += sweepAngle ;
    }

    _mPaint..color = Colors.white;
    canvas.drawCircle(Offset.zero, mInnerRadius, _mPaint);

    canvas.restore();

    double percentage = pieData.percentage*100;
    var texts ='${percentage.roundToDouble()}%';
    var tp = _newVerticalAxisTextPainter(texts)..layout();

    var textLeft = 35.0;
    tp.paint(canvas, Offset(textLeft, 50.0 - tp.height / 2));

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Api/Apis.dart';
import '../Entities/Entities.dart';
import '../main.dart';

class LoginSigninPage extends StatefulWidget {
  LoginSigninPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginSigninPageState createState() => _LoginSigninPageState();
}

class _LoginSigninPageState extends State<LoginSigninPage> {
  final FocusNode focusNode = FocusNode();
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();

  String title = "Log In";

  bool hasAccount = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _reEnterPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 220, 130, 1),
        centerTitle: true,
        leading: GestureDetector(
          onTap: (){
            if(hasAccount){
              Navigator.pop(context);
            }
            else{
              setState(() {
                hasAccount = true;
              });
            }
          },
          child: Icon(
            Icons.arrow_back
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: (){
              focusNode.unfocus();
              focusNode1.unfocus();
              focusNode2.unfocus();
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            )
          ),
          Flex(
            direction: Axis.vertical,
            children: [
              GestureDetector(
                onTap: (){
                  focusNode.unfocus();
                  focusNode1.unfocus();
                  focusNode2.unfocus();

                },
                child:
                Container(
                  height: 160,
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.shortestSide * 0.7893,
                  child: Form(
                      child: TextField(
                          focusNode: focusNode,
                          controller: _emailController,
                          style: TextStyle(fontSize: 12, ),
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                            ),
                            helperText: ' ',
                            filled: true,
                            contentPadding: EdgeInsets.only(left: 15, top: 5),
                            hintText: "Email Address",
                            suffixIcon: IconButton(
                              onPressed: _emailController.clear,
                              icon: Icon(Icons.clear, color: Colors.black),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          onSubmitted: (value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                      )
                  )
              ),
              Container(
                height: 24,
              ),
              Container(
                  width: MediaQuery.of(context).size.shortestSide * 0.7893,
                  child: Form(
                      child: TextField(
                        focusNode: focusNode1,
                        controller: _passwordController,
                        style: TextStyle(fontSize: 12, ),
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          helperText: ' ',
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 15, top: 5),
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: _passwordController.clear,
                            icon: Icon(Icons.clear, color: Colors.black),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        onSubmitted: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                  )
              ),
              Container(
                height: 24,
              ),
              (!hasAccount)?
              Container(
                  width: MediaQuery.of(context).size.shortestSide * 0.7893,
                  child: Form(
                      child: TextField(
                        focusNode: focusNode2,
                        controller: _reEnterPasswordController,
                        style: TextStyle(fontSize: 12, ),
                        decoration:  InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          helperText: ' ',
                          filled: true,
                          contentPadding: EdgeInsets.only(left: 15, top: 5),
                          hintText: "Enter Your Password Again",
                          suffixIcon: IconButton(
                            onPressed: _reEnterPasswordController.clear,
                            icon: Icon(Icons.clear, color: Colors.black),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        onSubmitted: (value) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                      )
                  )
              ):
              GestureDetector(
                onTap: (){
                  setState(() {
                    hasAccount = false;
                    title = "Sign In";
                  });
                },
                child: Text(
                  "Don't have an account?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                height: 48,
              ),
              GestureDetector(
                onTap: (){
                  if(hasAccount){
                    loginAction();
                  }
                  else{
                    signinAction();
                  }
                },
                child: Container(
                  height: 48,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.elliptical(20, 20),
                    ),
                    color: Color.fromRGBO(244, 220, 130, 1),
                  ),
                  child: Center(
                    child: Text(
                      "Confirm",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }

  void loginAction()async{
    print("start login");
    String url = Apis.baseApi + Apis.logIn; // Api here ignored

    try {
      var dio = Dio();
      var response = await dio.post(
        url,
        data: FormData.fromMap({
          'userEmail': _emailController.text,
          'userName': _emailController.text,
          'password': _passwordController.text,
        }),
      );
      print("log in response");
      print(response);

      final Map<String, dynamic> parsed = json.decode(response.toString());
      UserResponse result = UserResponse.fromJson(parsed);

      MyApp.isLogin = true;
      MyApp.userId = result.data.userId;
      Navigator.pop(context);

    } catch (e) {
      print(e);
    }
  }

  void signinAction()async{
    print("start signin");
    String url = Apis.baseApi + Apis.signIn; // Api here ignored

    try {
      var dio = Dio();
      var response = await dio.post(
        url,
        data: FormData.fromMap({
          'userEmail': _emailController.text,
          'userName': _emailController.text,
          'password': _passwordController.text,
        }),
      );
      print("sign in response");
      print(response);
      loginAction();

    } catch (e) {
      print(e);
    }
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Entities/Entities.dart';

class LoginSigninPage extends StatefulWidget {
  LoginSigninPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginSigninPageState createState() => _LoginSigninPageState();
}

class _LoginSigninPageState extends State<LoginSigninPage> {
  final FocusNode focusNode = FocusNode();

  String title = "Log In";

  bool hasAccount = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

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

                },
                child:
                Container(
                  height: 160,
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.shortestSide * 0.7893,
                  child: Form(
                      child: TextFormField(
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
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          validator: (value) {
                            if (value!.isEmpty) {return 'Please enter your email';}
                            if(!value.contains("@")){return 'Please enter a valid email address';}
                            return null;
                          }
                      )
                  )
              ),
              Container(
                height: 24,
              ),
              Container(
                  width: MediaQuery.of(context).size.shortestSide * 0.7893,
                  child: Form(
                      child: TextFormField(
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
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: _emailController.clear,
                            icon: Icon(Icons.clear, color: Colors.black),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        onFieldSubmitted: (value) {
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
                      child: TextFormField(
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
                          hintText: "Enter Your Password Again",
                          suffixIcon: IconButton(
                            onPressed: _emailController.clear,
                            icon: Icon(Icons.clear, color: Colors.black),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        onFieldSubmitted: (value) {
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

  void loginAction(){
    print("start login");
  }

  void signinAction(){
    print("start signin");

  }
}

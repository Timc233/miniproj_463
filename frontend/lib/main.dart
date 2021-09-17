import 'package:flutter/material.dart';
import 'package:untitled/Pages/ScanPage.dart';
import 'package:untitled/Pages/HomePage.dart';
import 'package:untitled/Pages/LoginSigninPage.dart';
import 'package:untitled/Pages/Pages.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static bool isLogin = false; // default false
  static int userId = -1; // default -1
  static String userName = "";
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EC463 Quick Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'EC463 Quick Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
    required this.title
  }) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
  int tabIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (tabIndex == 0)? HomePage():
            (tabIndex == 1)? ScanPage():
            ProfilePage(),
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: tabIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.add),
            title: Text(""),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            title: Text(""),
          )
        ],
        onTap: (i){
          if(i == 2){
            if(MyApp.isLogin){
              print("tap on index: " + i.toString());
              setState(() {
                tabIndex = i;
              });
            }
            else{
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginSigninPage()));

            }
          }
          else{
            print("tap on index: " + i.toString());
            setState(() {
              tabIndex = i;
            });

          }
        },
      ),
    );
  }


}

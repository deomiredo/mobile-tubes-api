import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modul_6/Login.dart';
import 'package:modul_6/Dashboard.dart';



class SplashScreen extends StatefulWidget{

  _SplashScreen createState() => _SplashScreen();

}

class _SplashScreen extends State<SplashScreen> {
  SharedPreferences pref;
  @override
  void initState() {
    validateLogin();
    super.initState();
  }

  void validateLogin() async {
    pref = await SharedPreferences.getInstance();
    if (pref.getString('username') == null) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      });
    }
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.6, 0.9],
              colors: [
                Color.fromRGBO(220, 235, 12, 1.0),
                Color.fromRGBO(198, 227, 32, 1.0),
                Color.fromRGBO(191, 255, 41, 1.0),
              ],
            ),
          ),
          width: 2000,
          height: 2000,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Icon(
                Icons.accessible_forward_rounded,
                size: 100.0,
                color: Colors.white,
              ),

              SizedBox(height: 24.0,),

              Text("Sakarep",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),

            ],
          ),
        ),


      ),
    );
  }

}
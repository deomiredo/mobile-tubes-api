import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:modul_6/dataAssisten.dart';
import 'package:modul_6/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  SharedPreferences pref;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(

        hintText: 'Username',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: userController,
    );

    final password = TextField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: passController,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
          onPressed: () async {
            String username = userController.text;
            String pass = passController.text;
            int i = 0;
            int temp = 0;
            while (i < dataAssisten.length) {
              if (username == dataAssisten[i]['UserName'] &&
                  pass == dataAssisten[i]['PassWord']) {
                pref = await SharedPreferences.getInstance();
                pref.setString('nim', username);
                pref.setString('username', dataAssisten[i]['FullName']);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              } else {
                temp++;
              }
              i++;
            }
            if (temp == dataAssisten.length) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                        content: Text("username atau password salah",
                            style: new TextStyle(fontSize: 16.0)));
                  });
            }
          },
        padding: EdgeInsets.all(12),
        color:  Color.fromRGBO(169, 194, 32, 1.0),
        child: Text('Login  ', style: TextStyle(color: Colors.white)),
      ),
    );

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
          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 250),
            children: <Widget>[
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 24.0),
              loginButton,
            ],
          ),
        ),
      ),
    );
  }
}
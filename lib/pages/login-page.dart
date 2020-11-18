import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ieeecrop/Animation/FadeAnimation.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:ieeecrop/main.dart';
import 'package:ieeecrop/second_screen.dart';
import 'package:ieeecrop/services/authentication-service.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController phonecontroller = TextEditingController();
  bool _isHidden = true;
  bool rememberMe = false;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  //Widget to get email and password from user

  Widget buildTextField(String hintText) {
    return new TextField(
      controller: hintText == translations.text('login.name')? namecontroller : phonecontroller,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        prefixIcon: hintText == translations.text('login.name') ? Icon(Icons.email) : Icon(Icons.lock),
        suffixIcon: hintText == translations.text('login.number')
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
      ),
      obscureText: hintText == translations.text('login.number')? _isHidden : false,
      autofocus: true,//Obscure logic
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 27,
                ),
                FadeAnimation(
                  1.8,
                  Stack(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        width: 380,
                        height: 380,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/Maati_high.png'),
                                fit: BoxFit.fill)),
                      ),
                    ),

                  ]),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: <Widget>[
                                buildTextField(translations.text('login.name')),
                                SizedBox(
                                  height: 9.0,
                                ),
                                buildTextField(translations.text('login.number')),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green.withOpacity(0.6),
                            ),
                            child: FlatButton(
                              onPressed: () async {
                                //Authentication and authorization
                               final String email = namecontroller.text;
                               final String password = phonecontroller.text;
                               print("$email $password");
                               final _token = await AuthenticationService()
                                   .login(email, password);
                               print("aksdlalksklcksa:"+_token);
                               if (_token != null) {
                                 var data = json.decode(_token);
                                 var rest = data["token"] as String;
                                 storage.write(key: "jwt", value: rest);  //Storing token in local storage
                                 print(rest);
                                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => mainpage()));
                               } else {
                                 //open up box COnstructor(message: res["message"])
                               }
                              },
                              child: Center(
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

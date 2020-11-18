import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieeecrop/Language/translation/global_translation.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class about_us extends StatelessWidget with DrawerStates {
  String emaila = "jailwalankit@gmail.com";
  String emails = "shivamaawarn15@gmail.com";
  String emailr = "rashisrivastava2001@gmail.com";
  String url = "https://openweathermap.org/api";
  String urlg = "https://github.com/Rashi-Srivastava/Maati-.git";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
                width: 340,
                child: Text(
                  translations.text('contact.intro'),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            translations.text('contact.api'),
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.withOpacity(0.6),
            ),
            child: FlatButton(
              onPressed: () {
                launch(url);
              },
              child: Center(
                child: Text(
                  "https://openweathermap.org/api",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            translations.text('contact.dev'),
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.withOpacity(0.6),
            ),
            child: FlatButton(
              onPressed: () {
                launch("mailto:$emaila");
              },
              child: Center(
                child: Text(
                  translations.text('contact.d1'),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.withOpacity(0.6),
            ),
            child: FlatButton(
              onPressed: () {
                launch("mailto:$emails");
              },
              child: Center(
                child: Text(
                  translations.text('contact.d2'),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.withOpacity(0.6),
            ),
            child: FlatButton(
              onPressed: () {
                launch("mailto:$emailr");
              },
              child: Center(
                child: Text(
                  translations.text('contact.d3'),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            translations.text('contact.g1'),
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 340,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrange.withOpacity(0.6),
            ),
            child: FlatButton(
              onPressed: () {
                launch(urlg);
              },
              child: Center(
                child: Text(
                  translations.text('contact.git'),
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),//Bold
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}

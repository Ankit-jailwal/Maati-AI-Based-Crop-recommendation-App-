import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieeecrop/Navigate_to_weather_api.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class Main_menu extends StatefulWidget with DrawerStates{
  @override
  Main_menu_State createState() => new Main_menu_State();
}

class Main_menu_State extends State<Main_menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Home()
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  Items item1 = new Items(
    title: "Maati Cam",
    subtitle: "",
    img: "assets/images/camera.png",
    page:"main",  );

  Items item2 = new Items(
    title: "Maati NEWS",
    subtitle: "",
    img: "assets/images/news.png",
    page:"news",
  );
  Items item3 = new Items(
    title: "Maati Analysis",
    subtitle: "",
    img: "assets/images/analysis.png",
    page:"analysis",
  );
  Items item4 = new Items(
    title: "Kisan call centre",
    subtitle: "",
    img: "assets/images/phone.png",
    page:"call",
  );
  Items item5 = new Items(
    title: "History",
    subtitle: "",
    img: "assets/images/history.png",
    page:"history",
  );
  Items item6 = new Items(
    title: "Contact us",
    subtitle: "",
    img: "assets/images/contact.png",
    page:"contact",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4, item5, item6];
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return GestureDetector(
              onTap: ()async{
                HapticFeedback.selectionClick();
                print("tapped");
                if(data.page=="main") {
                  BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                      .Createevent);
                }
                else if(data.page=="call")
                  {
                    launch("tel://1800-180-1551");
                  }
                else if(data.page=="analysis")
                  {
                    runApp(Weather_app());
                  }
                else if(data.page=="news") {
                  BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                      .news);
                }
                else if(data.page=="history")
                  {
                    BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                        .history);
                  }
                else if(data.page=="contact")
                {
                  BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                      .about);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.6), borderRadius: BorderRadius.circular(10),),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.subtitle,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
class Items {
  String title;
  String subtitle;
  String page;
  String img;
  Items({this.title, this.subtitle, this.page, this.img});
}


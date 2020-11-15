import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:ieeecrop/custom-widgets/core/custom-app-bar.dart';
import 'package:ieeecrop/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ieeecrop/pages/Output_screen.dart';
import 'package:ieeecrop/pages/about_us.dart';
import 'package:ieeecrop/pages/history.dart';
import 'package:ieeecrop/pages/Main_menu.dart';
import 'package:ieeecrop/pages/Profile_page.dart';
import 'package:ieeecrop/pages/News_feed.dart';
import 'package:ieeecrop/pages/login-page.dart';
import 'package:ieeecrop/second_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Functions_and_route.dart';
import '../Navigate_to_weather_api.dart';
import 'bottom_sheet_shape.dart';
import 'package:ieeecrop/pages/Maati_Cam.dart';
import 'drawer_item.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ieeecrop/constants.dart';

class DrawerLayout extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<DrawerLayout> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      //Future builder to retrieve data from server
      future: getuser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print(snapshot.data);
        if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(), //Circular progress indicator
          );
        } else {
          return ThemeProvider(
            initTheme: kLightTheme,
            child: Builder(
              builder: (context) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'IEEE APP',
                  theme: ThemeProvider.of(context),
                  home: BlocProvider<DrawerBloc>(
                    create: (context) => DrawerBloc(snapshot.data),
                    child: Drawermain(snapshot.data),
                  ),
                );
              },
            ),
          );
        }
      },
    ));
  }
}

class Drawermain extends StatefulWidget {
  final User user;
  Drawermain(this.user);
  @override
  _DrawermainState createState() => _DrawermainState(user);
}

class _DrawermainState extends State<Drawermain>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  final User user;
  _DrawermainState(this.user);
  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); //Global key
  @override

  //Functionality to manage animations and drawer

  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return OrientationBuilder(
      //Builder
      builder: (context, orientation) {
        return Scaffold(
          key: _scaffoldKey,
          body: Column(
            children: <Widget>[
              BlocBuilder<DrawerBloc, DrawerStates>(
                builder: (context, DrawerStates state) {
                  return CustomAppBar(
                    isBig: (state is UserScreen),
                    height: (state is UserScreen) ? 250 : 150,
                    leading: ThemeSwitcher(
                      builder: (context) {
                        return AnimatedCrossFade(
                          duration: Duration(milliseconds: 1),
                          crossFadeState: ThemeProvider.of(context)
                                      .brightness == // light and dark theme
                                  Brightness.light
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          firstChild: IconButton(
                            onPressed: () => ThemeSwitcher.of(context)
                                .changeTheme(theme: kDarkTheme),
                            icon: Container(
                              child: Center(
                                child: Icon(
                                  LineAwesomeIcons.moon_1,
                                  size: 34,
                                ),
                              ),
                            ),
                          ),
                          secondChild: IconButton(
                            onPressed: () => ThemeSwitcher.of(context)
                                .changeTheme(theme: kLightTheme),
                            icon: Container(
                              child: Center(
                                  child: Icon(
                                LineAwesomeIcons.sun,
                                size: 34,
                              )),
                            ),
                          ),
                        );
                      },
                    ),
                    title: findSelectedTitle(state),
                    trailing: IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState.openEndDrawer();
                      },
                      icon: Container(
                        child: Center(
                          child: Icon(
                            Icons.settings,
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                    childHeight: 100,
                  );
                },
              ),
              Expanded(
                child: BlocBuilder<DrawerBloc, DrawerStates>(
                  //Blocbuilder
                  builder: (context, DrawerStates state) {
                    return state as Widget;
                  },
                ),
              ),
            ],
          ),
          endDrawer: ClipPath(
            clipper: _DrawerClipper(),
            child: Drawer(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 48, bottom: 32),
                  height: (orientation == Orientation.portrait)
                      ? MediaQuery.of(context).size.height
                      : MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => mainpage()));
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(right: 20, bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Icon(
                            Icons.home,
                            size: 34,
                          ),
                        ),
                      ),
                      DrawerItem(
                        text: "Profile",
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .ProfileEvent); //Drawer navigation to Profile page
                        },
                      ),
                      DrawerItem(
                        text: "Main menu",
                        onPressed: () {
                          Navigator.pop(context);
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .menu); //Drawer navigation to Event screen
                        },
                      ),
                      DrawerItem(
                        text: "Maati NEWS",
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .news); //Drawer navigation to Create event screen
                        },
                      ),

                      DrawerItem(
                        text: "Maati Analysis",
                        onPressed:
                            () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Weather_app()));
                            }, //Drawer navigation to About page (Under construction)
                      ),
                      DrawerItem(
                        text: "Kisan call centre",
                        onPressed:
                            () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .Createevent);
                        }, //Drawer navigation to About page (Under construction)
                      ),
                      DrawerItem(
                        text: "History",
                        onPressed:
                            () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .history);
                        }, //Drawer navigation to About page (Under construction)
                      ),
                      DrawerItem(
                        text: "Contact us",
                        onPressed:
                            () {
                          Navigator.of(context).pop();
                          BlocProvider.of<DrawerBloc>(context).add(DrawerEvents
                              .about);
                        }, //Drawer navigation to About page (Under construction)
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _openSignOutDrawer(context);
                        },
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Not ${user.username}?",
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: "  Sign out", //Signout
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColorDark,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Stack(
                          //Social media handles
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: <Widget>[
                                IgnorePointer(
                                  child: Container(
                                    // comment or change to transparent color
                                    height: 150.0,
                                    width: 150.0,
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset.fromDirection(
                                      getRadiansFromDegree(270),
                                      degOneTranslationAnimation.value * 100),
                                  child: Transform(
                                    transform: Matrix4.rotationZ(
                                        getRadiansFromDegree(
                                            rotationAnimation.value))
                                      ..scale(degOneTranslationAnimation.value),
                                    alignment: Alignment.center,
                                    child: CircularButton(
                                      color: Colors.blue,
                                      width: 50,
                                      height: 50,
                                      icon: Icon(
                                        FontAwesomeIcons.instagram,
                                        color: Colors.white,
                                      ),
                                      onClick: () {
                                        _launchInBrowser(_launchURL_insta);
                                      },
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset.fromDirection(
                                      getRadiansFromDegree(225),
                                      degTwoTranslationAnimation.value * 100),
                                  child: Transform(
                                    transform: Matrix4.rotationZ(
                                        getRadiansFromDegree(
                                            rotationAnimation.value))
                                      ..scale(degTwoTranslationAnimation.value),
                                    alignment: Alignment.center,
                                    child: CircularButton(
                                      color: Colors.black,
                                      width: 50,
                                      height: 50,
                                      icon: Icon(
                                        FontAwesomeIcons.facebook,
                                        color: Colors.white,
                                      ),
                                      onClick: () {
                                        _launchInBrowser(_launchURL_fb);
                                      },
                                    ),
                                  ),
                                ),
                                Transform.translate(
                                  offset: Offset.fromDirection(
                                      getRadiansFromDegree(180),
                                      degThreeTranslationAnimation.value * 100),
                                  child: Transform(
                                    transform: Matrix4.rotationZ(
                                        getRadiansFromDegree(
                                            rotationAnimation.value))
                                      ..scale(
                                          degThreeTranslationAnimation.value),
                                    alignment: Alignment.center,
                                    child: CircularButton(
                                      color: Colors.orangeAccent,
                                      width: 50,
                                      height: 50,
                                      icon: Icon(
                                        FontAwesomeIcons.linkedin,
                                        color: Colors.white,
                                      ),
                                      onClick: () {
                                        _launchInBrowser(_launchURL_lin);
                                      },
                                    ),
                                  ),
                                ),
                                Transform(
                                  transform: Matrix4.rotationZ(
                                      getRadiansFromDegree(
                                          rotationAnimation.value)),
                                  alignment: Alignment.center,
                                  child: CircularButton(
                                    color: Colors.red,
                                    width: 60,
                                    height: 60,
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.white,
                                    ),
                                    onClick: () {
                                      if (animationController.isCompleted) {
                                        animationController.reverse();
                                      } else {
                                        animationController.forward();
                                      }
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// States for inherited widgets

String findSelectedTitle(DrawerStates state) {
  if (state is UserScreen) {
    return "User Profile";
  }
   else if (state is CreateEventScreen) {
    return "Maati Cam";
  }
  else if (state is Main_menu) {
    return "Main menu";
  }
   else if (state is history_screen) {
    return "History";
  }
   else if(state is Maati_news)
       return "Maati NEWS";
  else if(state is about_us)
    return "About Us";

}

//Signout animation and functionality

void _openSignOutDrawer(BuildContext context) {
  showModalBottomSheet(
      shape: BottomSheetShape(),
      backgroundColor: Theme.of(context).primaryColorLight,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            top: 24,
            bottom: 16,
            left: 48,
            right: 48,
          ),
          height: 180,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Are you sure you want to sign out?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        storage.delete(key: "jwt");
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => App()),
                        );
                      },
                      color: Theme.of(context).scaffoldBackgroundColor,
                      child: Text(
                        "Sign out",
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: OutlineButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => mainpage()),
                        );
                      },
                      borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "Stay logged in",
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}

// Curve in drawer

class _DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(50, 0);
    path.quadraticBezierTo(0, size.height / 2, 50, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}

// Social media links

String _launchURL_fb = 'https://www.facebook.com/ieeeditu';
String _launchURL_insta = 'https://www.instagram.com/ieeeditu/';
String _launchURL_lin =
    'https://www.linkedin.com/feed/update/urn:li:activity:6697023777416478720/';
Future<void> _launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'header_key': 'header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

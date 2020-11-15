import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/drawer_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:ieeecrop/constants.dart';

import 'custom-widgets/drawer_layout.dart';

//Navigating to mainpage aka home screen

class mainpage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocProvider<DrawerBloc>(
              create: (context) => DrawerBloc(null),
              child: DrawerLayout(),
            ),
          );
        },
      ),
    );
  }
}




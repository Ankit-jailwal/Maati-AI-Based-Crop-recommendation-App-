import 'package:flutter/material.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:search_widget/search_widget.dart';

class history_screen extends StatelessWidget with DrawerStates{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10,),
        Text("No history available",
        style: TextStyle(
          fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.w800,
          fontFamily: "Roberto"
        ),
        ),
        SizedBox(height: 40,),
        Container(
          height: 200,
          child: Image.asset(
              "assets/images/his.png"),
        ),
      ],
    );
  }
}



import 'package:flutter/material.dart';

// Draweritem Function user in Drawer layout

class DrawerItem extends StatelessWidget {

  final String text;
  final Function onPressed;

  const DrawerItem({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18
        ),
      ),
      onPressed: onPressed,
    );
  }
}


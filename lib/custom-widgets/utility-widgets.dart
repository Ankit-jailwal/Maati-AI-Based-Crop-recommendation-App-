import 'package:flutter/material.dart';

class DefaultCircularProgressIndicator extends StatelessWidget {
  const DefaultCircularProgressIndicator();
  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      backgroundColor: Theme.of(context).accentColor,
    );
  }
}

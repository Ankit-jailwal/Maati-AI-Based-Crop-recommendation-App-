import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  final Widget leading, trailing, child;
  final String title;
  final double height;
  final double childHeight;
  final bool isBig;

  const CustomAppBar(
      {Key key,
      this.leading,
      this.trailing,
      this.title,
      this.childHeight,
      this.isBig,
      this.child,
      this.height = kToolbarHeight})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);
  //Custom app bar Used in almost all the pages

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: _AppBarClipper(childHeight: childHeight, isBig: isBig),
          child: Container(
            padding: const EdgeInsets.only(top: 0),
            color: Theme.of(context).primaryColorDark.withOpacity(0.7),
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 40), child: leading),
                Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: FlatButton(
                      onPressed: null,
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ]),
                Padding(
                    padding: const EdgeInsets.only(top: 40), child: trailing)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: childHeight / 10,
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.centerRight,
            child: child,
          ),
        ),
      ],
    );
  }
}

class _AppBarClipper extends CustomClipper<Path> {
  final bool isBig;
  final double childHeight;

  _AppBarClipper({@required this.isBig, @required this.childHeight});

  @override
  Path getClip(Size size) {
    double height = isBig ? size.height - childHeight : size.height;
    Path path = Path();

    path.moveTo(0, height - 55);
    path.quadraticBezierTo(size.width/2 , height, size.width, height -55);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

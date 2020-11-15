import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieeecrop/bloc/drawer_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ieeecrop/constants.dart';
import 'package:ieeecrop/main.dart';
import 'package:ieeecrop/pages/login-page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ieeecrop/Functions_and_route.dart';

//Profile page

class UserScreen extends StatelessWidget with DrawerStates{
  User user;
  UserScreen(this.user);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: kSpacingUnit.w * 10,
              width: kSpacingUnit.w * 10,
              margin: EdgeInsets.only(top: kSpacingUnit.w * 1),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: kSpacingUnit.w * 5,
                    backgroundImage: AssetImage('assets/images/ssr.jpg'),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: kSpacingUnit.w * 2.5,
                      width: kSpacingUnit.w * 2.5,
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        heightFactor: kSpacingUnit.w * 1.5,
                        widthFactor: kSpacingUnit.w * 1.5,
                        child: Icon(
                          LineAwesomeIcons.pen,
                          color: kDarkPrimaryColor,
                          size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height:3),
          Container(
            height: 20,
            width: 80,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.greenAccent),
            child: Center(
              child: Text(
                "Admin",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),

            SizedBox(height: kSpacingUnit.w * 2),
            Text(
              '${user.username}',
              style: kTitleTextStyle,
            ),
            SizedBox(height: kSpacingUnit.w * 0.5),
            Text(
              '${user.email}',
              style: kCaptionTextStyle,
            ),
            SizedBox(height: kSpacingUnit.w * 2),
            Container(
              height: kSpacingUnit.w * 4,
              width: kSpacingUnit.w * 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                color: Theme.of(context).accentColor,
              ),
              child: Center(
                child: FlatButton(
                    child: Text(
                      'Become an Member',                                         //Become an member navigates user to IEEE SB DITU official website
                      style: kButtonTextStyle,
                    ),
                    onPressed: () {
                      _launchInBrowser(_launchURL);
                    }
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Container(
                height: kSpacingUnit.w * 5.5,
                margin: EdgeInsets.symmetric(
                  horizontal: kSpacingUnit.w * 4,
                ).copyWith(
                  bottom: kSpacingUnit.w * 2,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: kSpacingUnit.w * 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
                  color: Colors.black38,
                ),
                child: FlatButton(
                  onPressed: () {
                    logout();
                    print(storage.read(key: "jwt"));                           //logout logic deletes token from storage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        LineAwesomeIcons.alternate_sign_out,
                        size: kSpacingUnit.w * 2.5,
                      ),
                      SizedBox(width: kSpacingUnit.w * 1.5),
                      Text(
                        'Logout',
                        style: kTitleTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Future function for navigating to IEEE SB DITU official website

String _launchURL='http://www.ieeeditu.org.in/';
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


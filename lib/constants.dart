import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/painting.dart';

// Basically these are constants used in different widgets

const kSpacingUnit = 10; //These are used in profile page
const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);
const String text = // Text used in New_event_screen
    "We Have No Idea: \n A Guide to the Unknown offers a funny and informative romp through the mysteries of cosmology. Each chapter cleverly addresses a key cosmological question, such as whether or not there are higher than three dimensions, what are the missing pieces of the universe's material We Have No Idea: A Guide to the Unknown offers a funny and informative romp through the mysteries of cosmology. Each chapter cleverly addresses a key cosmological question, such as whether or not there are higher than three dimensions, what are the missing pieces of the universe's material We Have No Idea: A Guide to the Unknown offers a funny and informative romp through the mysteries of cosmology. Each chapter cleverly addresses a key cosmological question, such as whether or not there are higher than three dimensions, what are the missing pieces of the universe's material We Have No Idea: A Guide to the Unknown offers a funny and informative romp through the mysteries of cosmology. Each chapter cleverly addresses a key cosmological question, such as whether or not there are higher than three dimensions, what are the missing pieces of the universe's material";

const Color orange = Color(0xffF59C11);
const Color darkOrange = Color(0xffD78809);

final kTitleTextStyle = TextStyle(
  //These are used in profile page
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
  textTheme: ThemeData.dark().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kLightSecondaryColor,
        displayColor: kLightSecondaryColor,
      ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
);

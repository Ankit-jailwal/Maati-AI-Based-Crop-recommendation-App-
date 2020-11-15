import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ieeecrop/Weahter_API/blocs/weather_bloc.dart';
import 'package:ieeecrop/Weahter_API/models/remote/weather_response.dart';
import 'package:ieeecrop/Weahter_API/resources/application_localization_delegate.dart';
import 'package:ieeecrop/Weahter_API/resources/config/application_colors.dart';
import 'package:ieeecrop/Weahter_API/resources/config/dimensions.dart';
import 'package:ieeecrop/Weahter_API/resources/config/ids.dart';
import 'package:ieeecrop/Weahter_API/ui/screen/weather_main_page.dart';
import 'package:ieeecrop/Weahter_API/ui/screen/weather_main_sun_path_page.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/weather_main_widget.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/widget_helper.dart';
import 'package:ieeecrop/Weahter_API/utils/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ieeecrop/second_screen.dart';
import 'package:logging/logging.dart';

class WeatherMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:(){
        return Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => mainpage()));
      },
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: <Widget>[
              Container(
                  key: Key("weather_main_screen_container"),
                  decoration: BoxDecoration(
                      gradient: WidgetHelper.buildGradient(
                          ApplicationColors.nightStartColor,
                          ApplicationColors.nightEndColor)),
                  child: WeatherMainWidget()),
            ],
          )
      ),
    );

  }
}
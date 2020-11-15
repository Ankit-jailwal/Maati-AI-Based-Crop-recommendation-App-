import 'package:ieeecrop/Weahter_API/models/internal/overflow_menu_element.dart';
import 'package:ieeecrop/Weahter_API/models/internal/weather_forecast_holder.dart';
import 'package:ieeecrop/Weahter_API/resources/application_localization.dart';
import 'package:ieeecrop/Weahter_API/resources/config/application_colors.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/weather_forecast_widget.dart';
import 'package:ieeecrop/Weahter_API/ui/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherForecastScreen extends StatelessWidget {
  final WeatherForecastHolder _holder;
  const WeatherForecastScreen(this._holder);
  @override
  Widget build(BuildContext context) {
    LinearGradient gradient = WidgetHelper.getGradient(
        sunriseTime: _holder.system.sunrise, sunsetTime: _holder.system.sunset);
    print("Rebuild weather forecast screen");
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(
                key: Key("weather_main_screen_container"),
                decoration: BoxDecoration(gradient: gradient),
                child: WeatherForecastWidget(
                  holder: _holder,
                  width: 300,
                  height: 150,
                )),
          ],
        ));
  }
}

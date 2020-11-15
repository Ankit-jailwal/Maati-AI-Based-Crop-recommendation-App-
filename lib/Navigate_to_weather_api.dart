import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ieeecrop/Weahter_API/blocs/application_bloc.dart';
import 'package:ieeecrop/Weahter_API/resources/application_localization_delegate.dart';
import 'package:ieeecrop/Weahter_API/ui/screen/weather_main_screen.dart';
import 'package:flutter/material.dart';

class Weather_app extends StatelessWidget {

  Weather_app(){
    WidgetsFlutterBinding.ensureInitialized();
    applicationBloc.loadSavedUnit();
    applicationBloc.loadSavedRefreshTime();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherMainScreen(),
      debugShowCheckedModeBanner: false,
      theme: _configureThemeData(),
      localizationsDelegates: [
        const ApplicationLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }


  ThemeData _configureThemeData() {
    return ThemeData(
        textTheme: TextTheme(
            headline: TextStyle(fontSize: 60.0, color: Colors.white),
            title: TextStyle(fontSize: 35, color: Colors.white),
            subtitle: TextStyle(fontSize: 20, color: Colors.white),
            body1: TextStyle(fontSize: 15, color: Colors.white),
            body2: TextStyle(fontSize: 12, color: Colors.white)));
  }
}
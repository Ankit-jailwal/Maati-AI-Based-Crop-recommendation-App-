import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ieeecrop/Weahter_API/resources/repository/remote/weather_api_provider.dart';
import 'package:ieeecrop/main.dart';
import 'package:ieeecrop/pages/login-page.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity/connectivity.dart';

//Function to check internet connectivity
final weatherApiProvider = WeatherApiProvider();
String temp;
class ConnectionStatusSingleton {
  static final ConnectionStatusSingleton _singleton = new ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  static ConnectionStatusSingleton getInstance() => _singleton;

  bool hasConnection = false;

  StreamController connectionChangeController = new StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  void dispose() {
    connectionChangeController.close();
  }
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch(_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}

//ROUTING for homepage and mainpage
const String HomePageRoute = '/';
const String mainRoute = '/feed';
Route<dynamic> generateRoute(RouteSettings settings) {
  Widget page;

  switch (settings.name) {
   case HomePageRoute:
     page=LoginPage();
     break;
    case mainRoute:
      page=App();
      break;
    default:
      page=Scaffold(
        body: Center(
            child: Text('No route defined for ${settings.name}')),
      );
  }
      (context) => page;
}

// GET USER FUNCTION

Future getuser() async {
  var url = 'http://13.76.211.170:4000/user/me';
  http.Response response =
  await http.get(url, headers: {"token": await storage.read(key: "jwt")});
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    User user = User.fromJson(jsonDecode(response.body));
    print(response.body);
    print(user);
    return user;
  }
}


//USER MODAL

class User {
  DateTime createdAt;
  String id;
  String username;
  String email;
  String password;
  int v;

  User(
      this.createdAt,
      this.id,
      this.username,
      this.email,
      this.password,
      this.v,
      );

  factory User.fromJson(dynamic json) {
    return new User(
        DateTime.parse(json["createdAt"]),
        json["_id"] as String,
        json["username"] as String,
        json["email"] as String,
        json["password"] as String,
        json["__v"] as int);
  }

  @override
  String toString() {
    return '{ ${this.createdAt}, ${this.id} , ${this.username} , ${this.email} , ${this.password} , ${this.v} }';
  }
}

//Logout function(deletes token from storage)

void logout() async{
  storage.delete(key: "jwt");
}

//TOKEN

Future getoken(String email, String password) async{
  final String url="http://13.76.211.170:4000/user/login";

  Map<String, String>data= {
    "email": email,
    "password": password
  };
  final response= await http.post(url, headers: {"Content-Type": "application/json"},body:json.encode(data)
  );
  if(response.statusCode==200)
    return response.body;
  else
    return null;
}

Future crop_api_call(String base64,String temperature,String date,String pos) async{
  final String url="http://20.185.199.129:5000";
  Map<String, String>data= {
    "base64":base64,
    "ID":"1.png",
    "Loc_Cordinates":pos,
    "Temperature":temperature,
    "date": date
  };
  final response= await http.post(url, headers: {"Content-Type": "application/json"},body:json.encode(data)
  );
  print(response.statusCode);
  print(response.body);
  if(response.statusCode==200)
   return response.body;
  else
    return null;
}

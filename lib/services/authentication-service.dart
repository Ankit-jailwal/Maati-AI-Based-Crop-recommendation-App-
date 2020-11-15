import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieeecrop/main.dart';
import 'package:ieeecrop/Animation/FadeAnimation.dart';
import 'package:ieeecrop/second_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ieeecrop/Functions_and_route.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ieeecrop/config/config.dart';

class AuthenticationService {
  static AuthenticationService _singleton;

  final FlutterSecureStorage _secureStorage = new FlutterSecureStorage();
  final _storageBaseKey = 'auth-data';
  final _authTokenStorageKey = 'jwtToken';
  final server = getServerURI();

  bool initTokenSet = false;
  String _authToken;

  AuthenticationService._() {
    _secureStorage.read(key: generatekey(_authTokenStorageKey)).then((token) {
      initTokenSet = true;
      _setAuthToken(token);
    });
  }

  factory AuthenticationService() {
    if (_singleton == null) {
      _singleton = AuthenticationService._();
    }
    return _singleton;
  }

  String generatekey(String key) => _storageBaseKey + '/' + key;

//Logout function(deletes token from storage)

//TOKEN

  Future login(String email, String password) async {
    final String url = server + "/user/login";

    Map<String, String> data = {"username": email, "password": password};

    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data));
    final body = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200) {
      _setAuthToken(body["token"]);
      return response.body;
    }
    else
      return null;
  }

  Future<void> _setAuthToken(String token) {
    _authToken = token;
    return _secureStorage.write(
        key: generatekey(_authTokenStorageKey), value: token);
  }

  Future<void> logout() {
    return _setAuthToken(null);
  }

  bool get authenticationStatus {
    while (!initTokenSet);
    return _authToken != null;
  }
  String get authenticationToken => _authToken;
}


// Method #2 trail version(In use now!!)
var _page_state;
void auth_trail() async{
  WidgetsFlutterBinding.ensureInitialized();
  ConnectionStatusSingleton connectionStatus =  ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();
  if(connectionStatus.hasConnection== false)
  {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  Center(
          child: new CircularProgressIndicator(
            value: null,
            strokeWidth: 7.0,
          ),
        ),
      ),
    ));
  }
  final token = storage.read(key: "jwt");
  //final check = await check_token();
  print(check);
  if (token == null) {
    _page_state=App();
  } else {
    if (check == 200 || check == 300) {
      _page_state=mainpage();
    } else
      _page_state=App();
  }
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
      home: _page_state));
}

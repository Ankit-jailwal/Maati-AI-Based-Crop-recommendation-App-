import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieeecrop/pages/login-page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ieeecrop/services/authentication-service.dart';

final storage = FlutterSecureStorage();
final token = storage.read(key: "jwt");
int check;

//Main function to check internet and token before routing

void main() async {
  await auth_trail();
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LoginPage()
    );
  }
}
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();

class SecureStorageApi {
  static Future<String> read(String key) async {
    return await storage.read(key: key);
  }

  static Future<Map<String, String>> readAll(String key) async {
    return await storage.readAll();
  }

  static Future write(key, value) async {
    return await storage.write(key: key, value: value);
  }

  static Future delete(String key) async {
    return await storage.delete(key: key);
  }

  static Future deleteAll() async {
    return await storage.deleteAll();
  }
}

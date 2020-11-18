import 'dart:async';
import 'package:ieeecrop/Language/system_api/secure_storage_api.dart';

const String _storageKey = "Appli_";

Preferences preferences = Preferences();

class Preferences {
  /// ----------------------------------------------------------
  /// Generic routine to fetch a preference
  /// ----------------------------------------------------------
  Future<String> _getApplicationSavedInformation(String name) async {
    return await SecureStorageApi.read(_storageKey + name) ?? '';
  }

  /// ----------------------------------------------------------
  /// Generic routine to saves a preference
  /// ----------------------------------------------------------
  Future<bool> _setApplicationSavedInformation(
      String name, String value) async {
    return await SecureStorageApi.write(_storageKey + name, value);
  }

  /// ----------------------------------------------------------
  /// Method that saves/restores the preferred language
  /// ----------------------------------------------------------
  getPreferredLanguage() async {
    return _getApplicationSavedInformation('language');
  }

  setPreferredLanguage(String lang) async {
    return _setApplicationSavedInformation('language', lang);
  }

  // ------------------ SINGLETON -----------------------
  static final Preferences _preferences = Preferences._internal();
  factory Preferences() {
    return _preferences;
  }
  Preferences._internal();
}

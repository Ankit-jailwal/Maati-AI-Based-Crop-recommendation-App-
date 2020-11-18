import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'preferences.dart';

const String _kDefaultLanguage = "en";
String _kFallbackLanguage;

class GlobalTranslations {
  Locale _locale;
  Map<dynamic, dynamic> _localizedValues;
  Map<dynamic, dynamic> _fallbackValues;
  Map<String, String> _cache = {};
  List<String> _supportedLanguages = new List();

  ///
  /// Returns the list of supported locales
  ///
  Iterable<Locale> supportedLocales() =>
      _supportedLanguages.map<Locale>((lang) => Locale(lang, ''));

  ///
  /// Return the translation that corresponds to the [key]
  ///
  /// The [key] might be a sequence of [key].[sub-key].[sub-key]
  ///
  String text(String key, {Map<String, String> params}) {
    // Return the requested string
    String value = '** $key not found';

    if (_localizedValues != null) {
      // Get the translated string
      value = _getLocalizedValue(key, _localizedValues);

      //check if the translation was not found,
      ///In that case look the translation in the fallback language
      if (value == '** $key not found') {
        if (_fallbackValues != null) {
          value = _getLocalizedValue(key, _fallbackValues);
        }
      }
    }
    if (params != null) {
      /// If parametes is not null then replace all these params in the string
      value = mapParamsToTranslatedString(value, params);
    }
    return value;
  }

  String mapParamsToTranslatedString(String value, Map<String, String> params) {
    params.forEach((key, value1) {
      value = value.replaceAll('{{$key}}', value1);
    });
    return value;
  }

  _getLocalizedValue(key, Map<dynamic, dynamic> _values) {
    // Return the requested string
    String string = '** $key not found';

    // Check if the requested [key] is in the cache
    if (_cache[key] != null) {
      return _cache[key];
    }

    // Iterate the key until found or not
    bool found = true;
    List<String> _keyParts = key.split('.');
    int _keyPartsLen = _keyParts.length;
    int index = 0;
    int lastIndex = _keyPartsLen - 1;

    while (index < _keyPartsLen && found) {
      var value = _values[_keyParts[index]];

      if (value == null) {
        // Not found => STOP
        found = false;
        break;
      }

      // Check if we found the requested key
      if (value is String && index == lastIndex) {
        string = value;

        // Add to cache
        _cache[key] = string;
        break;
      }

      // go to next subKey
      _values = value;
      index++;
    }
    return string;
  }

  String get currentLanguage => _locale == null ? '' : _locale.languageCode;
  Locale get locale => _locale;

  ///
  ///One-time initialization
  ///["en","hi","bn","mr","ta","te","kn","ml","or","pa"]
  ///
  Future<Null> init(List<String> supportedLanguages,
      {String fallbackLanguage}) async {
    if (supportedLanguages == null) {
      throw new Exception('You must provide supported languages');
    }
    _supportedLanguages = supportedLanguages;
    if (fallbackLanguage != null &&
        _supportedLanguages.indexOf(fallbackLanguage) >= 0) {
      _kFallbackLanguage = fallbackLanguage;
      // Load the fallback language strings
      String jsonContent = await rootBundle
          .loadString("assets/locale/locale_$_kFallbackLanguage.json");
      _fallbackValues = json.decode(jsonContent);
    }
    if (_locale == null) {
      await setNewLanguage();
    }
    return null;
  }

  ///
  /// Routine to change the language
  ///
  Future<Null> setNewLanguage([String newLanguage]) async {
    String language = newLanguage;
    if (language == null) {
      language = await preferences.getPreferredLanguage();
    }

    // If not in the preferences, get the current locale (as defined at the device settings level)
    if (language == '') {
      String currentLocale = Platform.localeName.toLowerCase();
      if (currentLocale.length > 2) {
        if (currentLocale[2] == "-" || currentLocale[2] == "_") {
          language = currentLocale.substring(0, 2);
        }
      }
    }

    // Check if we are supporting the language
    // if not consider the default one
    if (!_supportedLanguages.contains(language)) {
      language = _kDefaultLanguage;
    }

    // Set the Locale
    _locale = Locale(language, "");

    // Load the language strings
    String jsonContent = await rootBundle
        .loadString("assets/locale/locale_${_locale.languageCode}.json");
    _localizedValues = json.decode(jsonContent);

    // Clear the cache
    _cache = {};

    return null;
  }

  /// ==========================================================
  /// Singleton Factory
  ///
  static final GlobalTranslations _translations =
      GlobalTranslations._internal();
  factory GlobalTranslations() {
    return _translations;
  }
  GlobalTranslations._internal();
}

GlobalTranslations translations = GlobalTranslations();

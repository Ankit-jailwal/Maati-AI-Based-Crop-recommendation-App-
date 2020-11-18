import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../global_translation.dart';
import '../preferences.dart';

part 'translation_event.dart';
part 'translation_state.dart';

class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  @override
  TranslationState get initialState => TranslationState(
        locale: translations.locale,
      );
  @override
  Stream<TranslationState> mapEventToState(
    TranslationEvent event,
  ) async* {
    if (event is SwitchLanguage) {
      await preferences.setPreferredLanguage(event.language);
      // Notification the translations module about the new language
      await translations.setNewLanguage(event.language);
      yield TranslationState(
        locale: translations.locale,
      );
    }
  }
}

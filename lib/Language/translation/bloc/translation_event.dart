part of 'translation_bloc.dart';

@immutable
abstract class TranslationEvent {}

class SwitchLanguage extends TranslationEvent {
  final String language;
  SwitchLanguage({this.language});
}

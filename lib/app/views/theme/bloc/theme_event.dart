// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final bool isDark;
  ThemeChanged(
    this.isDark,
  );
}


class Printtt extends ThemeEvent {
  
}

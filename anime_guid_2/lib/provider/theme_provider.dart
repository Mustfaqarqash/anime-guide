import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ColorScheme> {
  ThemeNotifier()
      : super(ColorScheme.fromSeed(
          seedColor: const Color(0xffE21221),
          brightness: Brightness.dark,
        ));

  get isDark => null;
  void changeTheme() {
    state = state == lightTheme ? darkTheme : lightTheme;
  }

  static final ColorScheme lightTheme = ColorScheme.fromSeed(
    seedColor: const Color(0xffE21221),
    brightness: Brightness.light,
  );

  static final darkTheme = ColorScheme.fromSeed(
    seedColor: const Color(0xffE21221),
    brightness: Brightness.dark,
  );
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ColorScheme>(
  (ref) => ThemeNotifier(),
);

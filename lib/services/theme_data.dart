import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  static ThemeData themeData(bool isdarkTheme, BuildContext buildContext) {
    return ThemeData(
       
        scaffoldBackgroundColor:
            isdarkTheme ? Colors.black : Color.fromARGB(255, 206, 206, 206),
        primaryColor: Colors.blue,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: isdarkTheme ? Colors.black : const Color(0xFFcccccc),
              brightness: isdarkTheme ? Brightness.dark : Brightness.light,
            ),
        cardColor: isdarkTheme ? Colors.black : const Color(0xFFcccccc),
        canvasColor: isdarkTheme ? Colors.black : Color(0xFFcccccc),
        buttonTheme: Theme.of(buildContext).buttonTheme.copyWith(
              colorScheme: isdarkTheme
                  ? const ColorScheme.dark()
                  : const ColorScheme.light(),
            ));
  }
}

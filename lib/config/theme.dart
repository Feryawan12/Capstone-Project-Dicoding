import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData light() {
    return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 7.3, vertical: 7.3),
        labelStyle: textStyleTheme(
            isLight: false, color: Colors.grey[600], isHead: false, size: 12.0),
        suffixIconColor: Colors.grey[600],
        errorStyle: textStyleTheme(
            isLight: false, color: Colors.red, isHead: false, size: 12.0),
      ),
      textTheme: Typography.blackMountainView.copyWith(
          displayLarge: Typography.blackMountainView.bodyText1
              ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
          displayMedium: Typography.blackMountainView.bodyText1
              ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
          displaySmall: Typography.blackMountainView.bodyText1
              ?.copyWith(fontSize: 11, fontWeight: FontWeight.w300),
          labelLarge: Typography.blackMountainView.bodyText1
              ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500)),
      primaryTextTheme: Typography.whiteMountainView.copyWith(
        displayLarge: Typography.whiteMountainView.bodyText1
            ?.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
        displayMedium: Typography.whiteMountainView.bodyText1
            ?.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
        displaySmall: Typography.whiteMountainView.bodyText1
            ?.copyWith(fontSize: 11, fontWeight: FontWeight.w300),
        labelLarge: Typography.whiteMountainView.bodyText1
            ?.copyWith(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          elevation: 0),
      colorScheme: ThemeData()
          .colorScheme
          .copyWith(primary: Colors.blue[600], secondary: Colors.black),
      scaffoldBackgroundColor: Colors.grey[200],
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor:
            MaterialStateProperty.resolveWith<Color?>((_) => Colors.blue[600]),
        elevation: MaterialStateProperty.resolveWith<double?>((_) => 0),
        padding: MaterialStateProperty.resolveWith<EdgeInsets?>(
            (_) => const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.4)),
        textStyle: MaterialStateProperty.resolveWith<TextStyle?>((_) =>
            Typography.whiteMountainView.bodyText1
                ?.copyWith(fontSize: 16.0, fontWeight: FontWeight.w500)),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((_) =>
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(13.0))),
      )),
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue[600],
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.0),
          )),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[600],
          titleTextStyle: textStyleTheme(isHead: true, size: 14.5),
          elevation: 0),
    );
  }

  static TextStyle? textStyleTheme(
      {bool isLight = true, bool isHead = false, double? size, Color? color}) {
    return TextStyle(
      fontFamily: 'Roboto',
      fontSize: size ?? (!isHead ? 15 : 24),
      color: color ?? (!isLight ? Colors.black : Colors.white),
      fontWeight: !isHead ? FontWeight.w400 : FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    );
  }
}

import 'package:flutter/material.dart';

extension ContextHelper on BuildContext {

  void pop<T extends Object>([T? result]) {
    Navigator.pop(this, result);
  }

  void navigateTo(Widget child, {bool replaceCurrent = false}) {
    if (replaceCurrent) {
      Navigator.of(this).push(MaterialPageRoute(builder: (_) => child));
    } else {
      Navigator.of(this)
          .pushReplacement(MaterialPageRoute(builder: (_) => child));
    }
  }

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => theme.textTheme;

  TextStyle? get headlineText1 => textTheme.headline1;
  TextStyle? get headlineText2 => textTheme.headline2;
  TextStyle? get headlineText3 => textTheme.headline3;
  TextStyle? get headlineText4 => textTheme.headline4;
  TextStyle? get headlineText5 => textTheme.headline5;
  TextStyle? get headlineText6 => textTheme.headline6;
  TextStyle? get bodyText1 => textTheme.bodyText1;
  TextStyle? get bodyText2 => textTheme.bodyText2;

  

}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class SmartBannerThemeData {
  const SmartBannerThemeData.ios()
      : backgroundColor = SmartBannerColorPalette.backgroundIOS,
        shadowColor = SmartBannerColorPalette.shadowIOS,
        _buttonColor = SmartBannerColorPalette.buttonIOS,
        _titleColor = SmartBannerColorPalette.titleIOS,
        _buttonTextStyle = SmartBannerTextStyles.buttonIOS,
        _titleTextStyle = SmartBannerTextStyles.titleIOS;

  // TODO: create real android theme
  const SmartBannerThemeData.androidDark()
      : backgroundColor = SmartBannerColorPalette.backgroundAndroidDark,
        shadowColor = Colors.black,
        _buttonColor = SmartBannerColorPalette.buttonIOS,
        _titleColor = SmartBannerColorPalette.titleIOS,
        _buttonTextStyle = SmartBannerTextStyles.buttonIOS,
        _titleTextStyle = SmartBannerTextStyles.titleIOS;

  factory SmartBannerThemeData.adaptive() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const SmartBannerThemeData.ios();
    } else {
      return const SmartBannerThemeData.androidDark();
    }
  }

  final Color backgroundColor;
  final Color shadowColor;
  final Color _buttonColor;
  final Color _titleColor;

  final TextStyle _buttonTextStyle;
  TextStyle get buttonTextStyle =>
      _buttonTextStyle.copyWith(color: _buttonColor);

  final TextStyle _titleTextStyle;
  TextStyle get titleTextStyle => _titleTextStyle.copyWith(color: _titleColor);
}

class SmartBannerTheme extends StatelessWidget {
  const SmartBannerTheme({
    super.key,
    required this.data,
    required this.child,
  });

  final SmartBannerThemeData data;
  final Widget child;

  static final _kFallbackTheme = SmartBannerThemeData.adaptive();

  static SmartBannerThemeData of(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedSmartBannerTheme>();
    return inheritedTheme?.theme.data ?? _kFallbackTheme;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedSmartBannerTheme(
      theme: this,
      child: child,
    );
  }
}

class _InheritedSmartBannerTheme extends InheritedWidget {
  const _InheritedSmartBannerTheme({
    required this.theme,
    required super.child,
  });

  final SmartBannerTheme theme;

  @override
  bool updateShouldNotify(_InheritedSmartBannerTheme oldWidget) {
    return theme.data != oldWidget.theme.data;
  }
}

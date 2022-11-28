import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class SmartBannerThemeData {
  const SmartBannerThemeData.ios()
      : backgroundColor = BannerColorPalette.backgroundIOS,
        shadowColor = BannerColorPalette.shadowIOS,
        _buttonColor = BannerColorPalette.buttonIOS,
        _titleColor = BannerColorPalette.titleIOS,
        _buttonTextStyle = BannerTextStyles.buttonIOS,
        _titleTextStyle = BannerTextStyles.titleIOS;

  // TODO: create real android theme
  const SmartBannerThemeData.androidDark()
      : backgroundColor = BannerColorPalette.backgroundAndroidDark,
        shadowColor = Colors.black,
        _buttonColor = BannerColorPalette.buttonIOS,
        _titleColor = BannerColorPalette.titleIOS,
        _buttonTextStyle = BannerTextStyles.buttonIOS,
        _titleTextStyle = BannerTextStyles.titleIOS;

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

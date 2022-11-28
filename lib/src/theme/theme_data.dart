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

  // TODO: create real android theme
  const SmartBannerThemeData.androidLight()
      : backgroundColor = BannerColorPalette.backgroundIOS,
        shadowColor = Colors.black,
        _buttonColor = BannerColorPalette.buttonIOS,
        _titleColor = BannerColorPalette.titleIOS,
        _buttonTextStyle = BannerTextStyles.buttonIOS,
        _titleTextStyle = BannerTextStyles.titleIOS;

  factory SmartBannerThemeData.androidAdaptive({required bool isDark}) {
    if (isDark) {
      return const SmartBannerThemeData.androidDark();
    } else {
      return const SmartBannerThemeData.androidLight();
    }
  }

  factory SmartBannerThemeData.adaptive({required bool isDark}) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const SmartBannerThemeData.ios();
    } else {
      return SmartBannerThemeData.androidAdaptive(isDark: isDark);
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

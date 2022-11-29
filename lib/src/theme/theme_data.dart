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
        _descriptionColor = BannerColorPalette.descriptionIOS,
        _buttonTextStyle = BannerTextStyles.buttonIOS,
        _titleTextStyle = BannerTextStyles.titleIOS,
        _descriptionTextStyle = BannerTextStyles.descriptionIOS;

  // TODO: create real android theme
  const SmartBannerThemeData.android()
      : backgroundColor = BannerColorPalette.backgroundAndroidDark,
        shadowColor = Colors.black,
        _buttonColor = BannerColorPalette.buttonIOS,
        _titleColor = BannerColorPalette.titleIOS,
        _descriptionColor = BannerColorPalette.descriptionIOS,
        _buttonTextStyle = BannerTextStyles.buttonIOS,
        _titleTextStyle = BannerTextStyles.titleIOS,
        _descriptionTextStyle = BannerTextStyles.descriptionIOS;

  factory SmartBannerThemeData.adaptive() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const SmartBannerThemeData.ios();
    } else {
      return const SmartBannerThemeData.android();
    }
  }

  final Color backgroundColor;
  final Color shadowColor;
  final Color _buttonColor;
  final Color _titleColor;
  final Color _descriptionColor;

  final TextStyle _buttonTextStyle;
  TextStyle get buttonTextStyle =>
      _buttonTextStyle.copyWith(color: _buttonColor);

  final TextStyle _titleTextStyle;
  TextStyle get titleTextStyle => _titleTextStyle.copyWith(color: _titleColor);

  final TextStyle _descriptionTextStyle;
  TextStyle get descriptionTextStyle =>
      _descriptionTextStyle.copyWith(color: _descriptionColor);
}

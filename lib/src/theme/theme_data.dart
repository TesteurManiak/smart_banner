import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

class SmartBannerThemeData {
  /// Create a [SmartBannerThemeData] with specific colors and text styles for
  /// iOS.
  const SmartBannerThemeData.ios()
      : backgroundColor = BannerColorPalette.backgroundIOS,
        shadowColor = BannerColorPalette.shadowIOS,
        buttonTextStyle = BannerTextStyles.buttonIOS,
        titleTextStyle = BannerTextStyles.titleIOS,
        descriptionTextStyle = BannerTextStyles.descriptionIOS,
        closeButtonTextStyle = BannerTextStyles.closeButtonIOS;

  /// Create a [SmartBannerThemeData] with specific colors and text styles for
  /// Android.
  const SmartBannerThemeData.android()
      : backgroundColor = BannerColorPalette.backgroundAndroid,
        shadowColor = Colors.black,
        buttonTextStyle = BannerTextStyles.buttonAndroid,
        titleTextStyle = BannerTextStyles.titleAndroid,
        descriptionTextStyle = BannerTextStyles.descriptionAndroid,
        closeButtonTextStyle = BannerTextStyles.closeButtonAndroid;

  /// Create a [SmartBannerThemeData] depending on the [defaultTargetPlatform].
  factory SmartBannerThemeData.adaptive() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const SmartBannerThemeData.ios();
    } else {
      return const SmartBannerThemeData.android();
    }
  }

  final Color backgroundColor;
  final Color shadowColor;
  final TextStyle buttonTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle descriptionTextStyle;
  final TextStyle closeButtonTextStyle;
}

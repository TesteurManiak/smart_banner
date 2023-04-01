import 'package:flutter/material.dart';
import 'package:smart_banner/src/theme/colors.dart';
import 'package:smart_banner/src/theme/text_styles.dart';

class SmartBannerThemeData {
  const SmartBannerThemeData({
    this.backgroundColor,
    this.shadowColor,
    this.buttonTextStyle,
    this.titleTextStyle,
    this.descriptionTextStyle,
    this.closeButtonTextStyle,
    this.backgroundImage,
  });

  /// Create a [SmartBannerThemeData] with specific colors and text styles for
  /// iOS.
  const SmartBannerThemeData.ios()
      : backgroundColor = BannerColorPalette.backgroundIOS,
        shadowColor = BannerColorPalette.shadowIOS,
        buttonTextStyle = BannerTextStyles.buttonIOS,
        titleTextStyle = BannerTextStyles.titleIOS,
        descriptionTextStyle = BannerTextStyles.descriptionIOS,
        closeButtonTextStyle = BannerTextStyles.closeButtonIOS,
        backgroundImage = null;

  /// Create a [SmartBannerThemeData] with specific colors and text styles for
  /// Android.
  const SmartBannerThemeData.android()
      : backgroundColor = BannerColorPalette.backgroundAndroid,
        shadowColor = Colors.black,
        buttonTextStyle = BannerTextStyles.buttonAndroid,
        titleTextStyle = BannerTextStyles.titleAndroid,
        descriptionTextStyle = BannerTextStyles.descriptionAndroid,
        closeButtonTextStyle = BannerTextStyles.closeButtonAndroid,
        backgroundImage = const DecorationImage(
          image: AssetImage(
            'assets/background.png',
            package: 'smart_banner',
          ),
          repeat: ImageRepeat.repeat,
        );

  /// Create a [SmartBannerThemeData] depending on the current [TargetPlatform].
  factory SmartBannerThemeData.adaptive(BuildContext context) {
    final targetPlatform = Theme.of(context).platform;

    switch (targetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return const SmartBannerThemeData.ios();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
      case TargetPlatform.android:
        return const SmartBannerThemeData.android();
    }
  }

  final Color? backgroundColor;
  final Color? shadowColor;
  final TextStyle? buttonTextStyle;
  final TextStyle? titleTextStyle;
  final TextStyle? descriptionTextStyle;
  final TextStyle? closeButtonTextStyle;
  final DecorationImage? backgroundImage;

  SmartBannerThemeData copyWith({
    Color? backgroundColor,
    Color? shadowColor,
    TextStyle? buttonTextStyle,
    TextStyle? titleTextStyle,
    TextStyle? descriptionTextStyle,
    TextStyle? closeButtonTextStyle,
    DecorationImage? backgroundImage,
  }) {
    return SmartBannerThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      buttonTextStyle: buttonTextStyle ?? this.buttonTextStyle,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      closeButtonTextStyle: closeButtonTextStyle ?? this.closeButtonTextStyle,
      backgroundImage: backgroundImage ?? this.backgroundImage,
    );
  }
}

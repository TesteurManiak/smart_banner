import 'package:flutter/material.dart';
import 'package:smart_banner/smart_banner.dart';

import 'custom_banner.dart';

class BannerModel extends ChangeNotifier {
  BannerPosition _position = BannerPosition.top;
  BannerPosition get position => _position;
  set position(BannerPosition value) {
    _position = value;
    notifyListeners();
  }

  BannerStyle _style = BannerStyle.ios;
  BannerStyle get style => _style;
  set style(BannerStyle value) {
    _style = value;
    notifyListeners();
  }

  bool _useThemeBuilder = false;
  bool get useThemeBuilder => _useThemeBuilder;
  set useThemeBuilder(bool value) {
    SmartBannerThemeData builder(BuildContext context) {
      return SmartBannerThemeData(
        backgroundColor: Theme.of(context).colorScheme.primary,
      );
    }

    _useThemeBuilder = value;
    _themeBuilder = value ? builder : null;
    notifyListeners();
  }

  BannerThemeBuilder? _themeBuilder;
  BannerThemeBuilder? get themeBuilder =>
      _useThemeBuilder ? _themeBuilder : null;

  bool _useCustomBanner = false;
  bool get useCustomBanner => _useCustomBanner;
  set useCustomBanner(bool value) {
    Widget builder(BuildContext _, BannerProperties properties) {
      return CustomBanner(properties: properties);
    }

    _useCustomBanner = value;
    _bannerBuilder = value ? builder : null;
    notifyListeners();
  }

  BannerBuilder? _bannerBuilder;
  BannerBuilder? get bannerBuilder => _useCustomBanner ? _bannerBuilder : null;
}

import 'package:flutter/material.dart';
import 'package:smart_banner/src/theme/theme_data.dart';

class SmartBannerTheme extends StatelessWidget {
  const SmartBannerTheme({
    super.key,
    required this.data,
    required this.child,
  });

  final SmartBannerThemeData data;
  final Widget child;

  static SmartBannerThemeData of(BuildContext context) {
    final inheritedTheme = context
        .dependOnInheritedWidgetOfExactType<_InheritedSmartBannerTheme>();
    final platform = Theme.of(context).platform;
    return inheritedTheme?.theme.data ??
        SmartBannerThemeData.adaptive(platform);
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

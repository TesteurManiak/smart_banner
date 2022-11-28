import 'package:flutter/material.dart';

import 'theme_data.dart';

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

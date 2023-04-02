import 'package:flutter/material.dart';
import 'package:smart_banner/src/theme/theme_data.dart';
import 'package:smart_banner/src/utils/target_platform_extension.dart';

typedef BannerThemeFetcher = SmartBannerThemeData Function(
  TargetPlatform platform,
);

enum BannerStyle {
  adaptive(_adaptiveThemeFetcher),
  android(_androidThemeFetcher),
  ios(_iosThemeFetcher);

  const BannerStyle(this.themeFetcher);

  final BannerThemeFetcher themeFetcher;
}

SmartBannerThemeData _adaptiveThemeFetcher(TargetPlatform platform) {
  return SmartBannerThemeData.adaptive(platform);
}

SmartBannerThemeData _androidThemeFetcher(TargetPlatform _) {
  return const SmartBannerThemeData.android();
}

SmartBannerThemeData _iosThemeFetcher(TargetPlatform _) {
  return const SmartBannerThemeData.ios();
}

extension PlatformStyleExtension on BannerStyle {
  bool isAndroid(BuildContext context) {
    final targetPlatform = Theme.of(context).platform;
    switch (this) {
      case BannerStyle.adaptive:
        return targetPlatform.isAndroid;
      case BannerStyle.android:
        return true;
      case BannerStyle.ios:
        return false;
    }
  }
}

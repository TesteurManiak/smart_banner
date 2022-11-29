import 'package:flutter/foundation.dart';

import 'utils/target_platform_extension.dart';

enum BannerStyle {
  adaptive,
  android,
  ios,
}

extension PlatformStyleExtension on BannerStyle {
  bool get isAndroid {
    switch (this) {
      case BannerStyle.adaptive:
        return defaultTargetPlatform.isAndroid;
      case BannerStyle.android:
        return true;
      case BannerStyle.ios:
        return false;
    }
  }
}

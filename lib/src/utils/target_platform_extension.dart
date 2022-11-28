import 'package:flutter/foundation.dart';

extension SupportedPlatformExtension on TargetPlatform {
  bool get isAndroid => this == TargetPlatform.android;
  bool get isIOS => this == TargetPlatform.iOS;
  bool get isSupported => isAndroid || isIOS;
}

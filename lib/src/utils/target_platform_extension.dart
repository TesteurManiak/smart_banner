import 'package:flutter/foundation.dart';

extension SupportedPlatformExtension on TargetPlatform {
  bool get isAndroid => this == TargetPlatform.android;
}

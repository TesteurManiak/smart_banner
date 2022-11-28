import 'package:flutter/foundation.dart';

class SmartBannerProperty<T> {
  const SmartBannerProperty({
    required this.onIOS,
    required this.onAndroid,
  });

  /// Property value on iOS browser.
  final T onIOS;

  /// Property value on Android browser.
  final T onAndroid;

  /// Return the property value based on the [defaultTargetPlatform].
  T get property =>
      defaultTargetPlatform == TargetPlatform.android ? onAndroid : onIOS;
}

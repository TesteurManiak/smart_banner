import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BannerProperties {
  const BannerProperties({
    required this.title,
    required this.buttonLabel,
    required this.icon,
    required this.androidProperties,
    required this.iosProperties,
    this.author,
    this.appStoreLanguage,
    this.onClose,
  });

  /// App title.
  final String title;

  /// The label of the install button that will be displayed on the banner.
  final String buttonLabel;

  final Widget icon;
  final BannerPropertiesAndroid androidProperties;
  final BannerPropertiesIOS iosProperties;

  /// App author.
  final String? author;

  /// Language code for the App Store.
  ///
  /// Defaults to the current locale.
  final String? appStoreLanguage;

  /// Callback when the banner is closed.
  final VoidCallback? onClose;

  SmartBannerProperties get platformProperties {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidProperties;
      default:
        return iosProperties;
    }
  }
}

class BannerPropertiesIOS extends SmartBannerProperties {
  const BannerPropertiesIOS({
    required super.appId,
    super.storeText,
    super.priceText,
    super.url,
  });
}

class BannerPropertiesAndroid extends SmartBannerProperties {
  const BannerPropertiesAndroid({
    required String packageName,
    super.storeText,
    super.priceText,
    super.url,
  }) : super(
          appId: packageName,
        );

  String get packageName => appId;
}

/// Class that represents the properties supported by the banner.
abstract class SmartBannerProperties {
  const SmartBannerProperties({
    required this.appId,
    this.storeText,
    this.priceText,
    this.url,
  });

  /// App id.
  ///
  /// Correspond to the bundle id on iOS and the package name on Android. This
  /// is used to open the app store if no [url] is provided.
  final String appId;

  /// The text that will be displayed on the banner.
  ///
  /// ex: "On the App Store" or "In Google Play"
  final String? storeText;

  /// Text that will be displayed on the banner to inform the user about the
  /// price.
  ///
  /// ex: "Free", "$3.99", etc.
  final String? priceText;

  /// Url that should be launched if the app is installed on the device.
  ///
  /// Otherwise, the store page will be opened.
  final String? url;
}

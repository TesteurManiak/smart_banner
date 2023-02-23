import 'package:flutter/material.dart';
import 'package:smart_banner/src/core/banner_style.dart';
import 'package:smart_banner/src/utils/target_platform_extension.dart';

class BannerProperties {
  const BannerProperties({
    required this.title,
    required this.buttonLabel,
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

  SmartBannerProperties getPropertiesFromStyle(
    BuildContext context,
    BannerStyle style,
  ) {
    final targetPlatform = Theme.of(context).platform;

    switch (style) {
      case BannerStyle.adaptive:
        return targetPlatform.isAndroid ? androidProperties : iosProperties;
      case BannerStyle.android:
        return androidProperties;
      case BannerStyle.ios:
        return iosProperties;
    }
  }
}

class BannerPropertiesIOS extends SmartBannerProperties {
  const BannerPropertiesIOS({
    required super.appId,
    required super.icon,
    super.storeText,
    super.priceText,
    super.url,
  }) : super(
          storeTemplateUrl: 'https://apps.apple.com/{lang}/app/id{appId}',
        );
}

class BannerPropertiesAndroid extends SmartBannerProperties {
  const BannerPropertiesAndroid({
    required String packageName,
    required super.icon,
    super.storeText,
    super.priceText,
    super.url,
  }) : super(
          appId: packageName,
          storeTemplateUrl:
              'https://play.google.com/store/apps/details?id={appId}&hl={lang}',
        );

  String get packageName => appId;
}

/// Class that represents the properties supported by the banner.
abstract class SmartBannerProperties {
  const SmartBannerProperties({
    required this.appId,
    required this.icon,
    required String storeTemplateUrl,
    this.storeText,
    this.priceText,
    this.url,
  }) : _storeTemplateUrl = storeTemplateUrl;

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

  final String _storeTemplateUrl;

  final Widget icon;

  String createStoreUrl(String lang) {
    return _storeTemplateUrl
        .replaceFirst('{lang}', lang)
        .replaceFirst('{appId}', appId);
  }
}

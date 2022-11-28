import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'banner_property.dart';

class BannerProperties {
  const BannerProperties.withUrl({
    required this.title,
    required this.buttonLabel,
    required this.storeText,
    required this.priceText,
    required this.icon,
    required SmartBannerUri this.url,
    this.author,
    this.appStoreLanguage,
    this.onClose,
  }) : id = null;

  const BannerProperties.withId({
    required this.title,
    required this.buttonLabel,
    required this.storeText,
    required this.priceText,
    required this.icon,
    required SmartBannerId this.id,
    this.author,
    this.appStoreLanguage,
    this.onClose,
  }) : url = null;

  /// App title.
  final String title;

  /// The label of the install button that will be displayed on the banner.
  final String buttonLabel;

  /// The text that will be displayed on the banner.
  final StoreText storeText;

  /// Price text.
  final PriceText priceText;

  final Widget icon;

  final SmartBannerUri? url;
  final SmartBannerId? id;

  /// App author.
  final String? author;

  /// Language code for the App Store.
  ///
  /// Defaults to the current locale.
  final String? appStoreLanguage;

  /// Callback when the banner is closed.
  final VoidCallback? onClose;
}

class StoreText extends BannerProperty<String> {
  const StoreText({
    required super.onAndroid,
    required super.onIOS,
  });

  const StoreText.fromText(String text)
      : super(
          onAndroid: text,
          onIOS: text,
        );
}

class PriceText extends BannerProperty<String> {
  const PriceText({
    required super.onAndroid,
    required super.onIOS,
  });

  const PriceText.fromPrice(
    String price,
  ) : super(
          onAndroid: price,
          onIOS: price,
        );
}

class SmartBannerUri extends BannerProperty<Uri> {
  const SmartBannerUri({
    required super.onAndroid,
    required super.onIOS,
  });
}

class SmartBannerId extends BannerProperty<String> {
  const SmartBannerId({
    required super.onAndroid,
    required super.onIOS,
  });

  String createUrl({
    required String lang,
  }) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return 'https://play.google.com/store/apps/details?id=$onAndroid&hl=$lang';
    } else {
      return 'https://apps.apple.com/$lang/app/id$onIOS';
    }
  }
}

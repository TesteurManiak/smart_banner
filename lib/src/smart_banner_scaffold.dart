import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'banner_position.dart';
import 'banner_properties.dart';
import 'banner_style.dart';
import 'smart_banner.dart';
import 'theme.dart';

class SmartBannerScaffold extends StatelessWidget {
  const SmartBannerScaffold({
    super.key,
    required this.child,
    this.position = BannerPosition.top,
    this.style = BannerStyle.adaptive,
  });

  final Widget child;
  final BannerPosition position;
  final BannerStyle style;

  @override
  Widget build(BuildContext context) {
    // If not on a web app, just return the child
    if (!kIsWeb) return child;

    final SmartBannerThemeData effectiveTheme;
    switch (style) {
      case BannerStyle.adaptive:
        effectiveTheme = SmartBannerThemeData.adaptive();
        break;
      case BannerStyle.android:
        // TODO: check brightness to return dark or light theme
        effectiveTheme = const SmartBannerThemeData.androidDark();
        break;
      case BannerStyle.ios:
        effectiveTheme = const SmartBannerThemeData.ios();
        break;
    }

    final banner = SmartBanner(
      properties: BannerProperties.withUrl(
        title: 'MyPage',
        buttonLabel: 'VIEW',
        storeText: const StoreText(
          onIOS: 'On the App Store',
          onAndroid: 'In Google Play',
        ),
        priceText: const PriceText.fromPrice('Free'),
        url: SmartBannerUri(
          onAndroid: Uri(),
          onIOS: Uri(),
        ),
        icon: const _AppImagePlaceholder(),
      ),
      style: style,
    );

    final size = MediaQuery.of(context).size;
    final height = size.height - banner.preferredSize.height;
    final children = <Widget>[
      banner,
      ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: child,
      ),
    ];

    return SmartBannerTheme(
      data: effectiveTheme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: position == BannerPosition.top
            ? children
            : children.reversed.toList(),
      ),
    );
  }
}

class _AppImagePlaceholder extends StatelessWidget {
  const _AppImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: 57,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

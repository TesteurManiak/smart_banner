import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'smart_banner.dart';
import 'smart_banner_position.dart';
import 'smart_banner_properties.dart';

class SmartBannerScaffold extends StatelessWidget {
  const SmartBannerScaffold({
    super.key,
    required this.child,
    this.position = SmartBannerPosition.top,
    this.style = SmartBannerStyle.adaptive,
  });

  final Widget child;
  final SmartBannerPosition position;
  final SmartBannerStyle style;

  @override
  Widget build(BuildContext context) {
    // If not on a web app, just return the child
    if (!kIsWeb) return child;

    final banner = SmartBanner(
      properties: SmartBannerProperties.withUrl(
        title: 'MyPage',
        buttonLabel: 'VIEW',
        storeText: const StoreText(
          onIOS: 'On the App Store',
          onAndroid: 'In Google Play',
        ),
        priceText: const PriceText.fromPrice('FREE'),
        url: SmartBannerUri(
          onAndroid: Uri(),
          onIOS: Uri(),
        ),
        icon: const SmartBannerAssetIcon.fromAsset(''),
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

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: position == SmartBannerPosition.top
          ? children
          : children.reversed.toList(),
    );
  }
}

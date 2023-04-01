import 'package:flutter/material.dart';
import 'package:smart_banner/smart_banner.dart';

class TestableSmartBannerScaffold extends StatelessWidget {
  const TestableSmartBannerScaffold({
    super.key,
    required this.isShown,
  });

  final bool isShown;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Localizations(
          locale: const Locale('en'),
          delegates: const [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
          ],
          child: SmartBannerScaffold(
            isShown: isShown,
            properties: const BannerProperties(
              title: 'Facebook',
              buttonLabel: 'VIEW',
              androidProperties: BannerPropertiesAndroid(
                packageName: 'com.facebook.katana',
                storeText: 'In Google Play',
                priceText: 'Free',
                icon: SizedBox.shrink(),
              ),
              iosProperties: BannerPropertiesIOS(
                appId: '284882215',
                storeText: 'On the App Store',
                priceText: 'Free',
                icon: SizedBox.shrink(),
              ),
            ),
            child: const Scaffold(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_banner/smart_banner.dart';

import 'banner_model.dart';
import 'separated_column.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BannerModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerModel = context.watch<BannerModel>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(platform: bannerModel.style.toTargetPlatform()),
      builder: (_, child) {
        if (child != null) {
          final icon = Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/c/cd/Facebook_logo_%28square%29.png',
          );

          return SmartBannerScaffold(
            isShown: true,
            style: bannerModel.style,
            position: bannerModel.position,
            themeBuilder: bannerModel.themeBuilder,
            bannerBuilder: bannerModel.bannerBuilder,
            properties: BannerProperties(
              title: 'Facebook',
              buttonLabel: 'VIEW',
              androidProperties: BannerPropertiesAndroid(
                packageName: 'com.facebook.katana',
                storeText: 'In Google Play',
                priceText: 'Free',
                icon: icon,
              ),
              iosProperties: BannerPropertiesIOS(
                appId: '284882215',
                storeText: 'On the App Store',
                priceText: 'Free',
                icon: icon,
              ),
            ),
            child: child,
          );
        }
        return const SizedBox.shrink();
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final bannerModel = context.watch<BannerModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: SeparatedColumn(
          mainAxisSize: MainAxisSize.min,
          separator: const SizedBox(height: 16),
          children: [
            ElevatedButton(
              onPressed: () => SmartBannerScaffold.showBanner(context),
              child: const Text('Show Banner'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyHomePage(),
                ),
              ),
              child: const Text('Push Page'),
            ),
            DropdownButton<BannerPosition>(
              value: bannerModel.position,
              items: BannerPosition.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              onChanged: (position) {
                if (position != null) {
                  bannerModel.position = position;
                }
              },
            ),
            DropdownButton<BannerStyle>(
              value: bannerModel.style,
              items: BannerStyle.values
                  .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
                  .toList(),
              onChanged: (style) {
                if (style != null) {
                  bannerModel.style = style;
                }
              },
            ),
            SwitchListTile(
              title: const Text('Use custom theme'),
              value: bannerModel.useThemeBuilder,
              onChanged: (useThemeBuilder) {
                bannerModel.useThemeBuilder = useThemeBuilder;
              },
            ),
            SwitchListTile(
              title: const Text('Use custom banner'),
              value: bannerModel.useCustomBanner,
              onChanged: (useCustomBanner) {
                bannerModel.useCustomBanner = useCustomBanner;
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension on BannerStyle {
  TargetPlatform? toTargetPlatform() {
    switch (this) {
      case BannerStyle.adaptive:
        return null;
      case BannerStyle.android:
        return TargetPlatform.android;
      case BannerStyle.ios:
        return TargetPlatform.iOS;
    }
  }
}

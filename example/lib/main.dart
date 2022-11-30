import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_banner/smart_banner.dart';

import 'separated_column.dart';

class BannerModel extends ChangeNotifier {
  BannerPosition _position = BannerPosition.top;
  BannerPosition get position => _position;
  set position(BannerPosition value) {
    _position = value;
    notifyListeners();
  }

  BannerStyle _style = BannerStyle.ios;
  BannerStyle get style => _style;
  set style(BannerStyle value) {
    _style = value;
    notifyListeners();
  }
}

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
      builder: (context, child) {
        if (child != null) {
          final icon = Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/c/cd/Facebook_logo_%28square%29.png',
          );

          return SmartBannerScaffold(
            style: bannerModel.style,
            position: bannerModel.position,
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
          ],
        ),
      ),
    );
  }
}

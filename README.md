# Smart Banner

[![Pub Version](https://img.shields.io/pub/v/smart_banner)](https://pub.dev/packages/smart_banner)

Display a smart banner on top of the screen of your Flutter Web application.

Inspired by [smart-app-banner](https://github.com/kudago/smart-app-banner/) and [react-smartbanner](https://github.com/patw0929/react-smartbanner)

## Usage

Wrap your view with a `SmartBannerScaffold` widget, if you want a persistant banner on top of your app you might need to directly use it inside the `MaterialApp.builder` property.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        if (child != null) {
          return SmartBannerScaffold(
            properties: BannerProperties(
              title: 'MyApp',
              buttonLabel: 'VIEW',
              androidProperties: BannerPropertiesAndroid(
                packageName: 'com.my.app',
                icon: Image.asset('assets/android_icon.png'),
              ),
              iosProperties: BannerPropertiesIOS(
                appId: '123456789',
                icon: Image.asset('assets/ios_icon.png'),
              ),
            ),
            child: child,
          );
        }
        return child;
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

For a more complete example, see [example](https://github.com/TesteurManiak/smart_banner/blob/main/example/lib/main.dart).

## Screenshots

![Android Style](https://github.com/TesteurManiak/smart_banner/blob/main/screenshots/android_style.png?raw=true)
![iOS Style](https://github.com/TesteurManiak/smart_banner/blob/main/screenshots/ios_style.png?raw=true)
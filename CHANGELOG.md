## 0.2.2

* Added property `isShown` to override the display of the banner

## 0.2.1

* Fixed exception in `SmartBannerThemeData.adaptive`

## 0.2.0+1

* Added screenshots to the pubspec.yaml

## 0.2.0

* Detect when the browser is running on MacOS to use the iOS style banner
* Added the issue tracker and repository links to the pubspec.yaml

### Breaking changes

* `PlatformStyleExtension.isAndroid` is now private (and `PlatformStyleExtension.isIOS` has been removed)
* `SmartBannerThemeData.adaptive` constructor is now taking a `BuildContext`
* `BannerProperties.getPropertiesFromStyle` is now taking a `BuildContext` as its first parameter

## 0.1.0+1

* Fixed screenshots in the README.md

## 0.1.0

* Initial release

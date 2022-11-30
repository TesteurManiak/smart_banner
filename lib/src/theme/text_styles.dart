import 'package:flutter/material.dart';

import 'colors.dart';

class BannerTextStyles {
  const BannerTextStyles._();

  static const buttonIOS = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
    color: BannerColorPalette.buttonIOS,
  );
  static const titleIOS = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
    color: BannerColorPalette.titleIOS,
  );
  static const titleAndroid = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w700,
    overflow: TextOverflow.ellipsis,
    color: BannerColorPalette.titleAndroid,
  );
  static const descriptionIOS = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w300,
    color: BannerColorPalette.descriptionIOS,
  );
  static const descriptionAndroid = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w700,
    color: BannerColorPalette.descriptionAndroid,
  );
  static const closeButtonIOS = TextStyle(
    fontSize: 18.0,
    color: BannerColorPalette.closeButtonIOS,
  );
  static const closeButtonAndroid = TextStyle(
    fontSize: 17.0,
    color: BannerColorPalette.closeButtonAndroid,
    backgroundColor: BannerColorPalette.closeButtonBackgroundAndroid,
  );
}

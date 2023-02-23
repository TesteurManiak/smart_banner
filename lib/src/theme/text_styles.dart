import 'package:flutter/material.dart';
import 'package:smart_banner/src/theme/colors.dart';

class BannerTextStyles {
  const BannerTextStyles._();

  static const buttonIOS = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: BannerColorPalette.buttonIOS,
  );
  static const buttonAndroid = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xFFd1d1d1),
    backgroundColor: Color(0xFF42b6c9),
  );
  static const titleIOS = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
    color: BannerColorPalette.titleIOS,
  );
  static const titleAndroid = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    overflow: TextOverflow.ellipsis,
    color: BannerColorPalette.titleAndroid,
  );
  static const descriptionIOS = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w300,
    color: BannerColorPalette.descriptionIOS,
  );
  static const descriptionAndroid = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: BannerColorPalette.descriptionAndroid,
  );
  static const closeButtonIOS = TextStyle(
    fontSize: 18,
    color: BannerColorPalette.closeButtonIOS,
  );
  static const closeButtonAndroid = TextStyle(
    fontSize: 17,
    color: BannerColorPalette.closeButtonAndroid,
    backgroundColor: BannerColorPalette.closeButtonBackgroundAndroid,
  );
}

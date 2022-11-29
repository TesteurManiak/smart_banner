import 'package:flutter/material.dart';

class BannerTextStyles {
  const BannerTextStyles._();

  static const buttonIOS = TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w400,
  );
  static const titleIOS = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    overflow: TextOverflow.ellipsis,
  );
  static const titleAndroid = TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w700,
    overflow: TextOverflow.ellipsis,
  );
  static const descriptionIOS = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w300,
  );
  static const descriptionAndroid = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w700,
  );
}

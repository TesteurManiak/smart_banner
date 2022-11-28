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
}

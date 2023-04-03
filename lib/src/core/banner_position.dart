import 'package:flutter/material.dart';

enum BannerPosition {
  top(Offset(0, -1)),
  bottom(Offset(0, 1));

  const BannerPosition(this.offset);

  final Offset offset;
}

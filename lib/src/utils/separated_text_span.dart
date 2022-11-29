import 'package:flutter/material.dart';

class SeparatedTextSpan extends TextSpan {
  SeparatedTextSpan({
    List<InlineSpan> children = const [],
    required InlineSpan separator,
  }) : super(
          children: [
            ..._childrenWithSeparator(children, separator),
          ],
        );

  static Iterable<InlineSpan> _childrenWithSeparator(
    List<InlineSpan> children,
    InlineSpan separator,
  ) sync* {
    for (int i = 0; i < children.length; i++) {
      if (i > 0) {
        yield separator;
      }
      yield children[i];
    }
  }
}

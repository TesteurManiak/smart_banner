import 'package:flutter/material.dart';

import '../core/banner_style.dart';
import 'smart_banner_scaffold.dart';

class AdaptiveCloseButton extends StatelessWidget {
  const AdaptiveCloseButton({
    super.key,
    required this.style,
    required this.onClose,
  });

  final BannerStyle style;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        SmartBannerScaffold.hideBanner(context);
        onClose?.call();
      },
      iconSize: 18,
      icon: const Text('×'),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smart_banner/src/theme/theme.dart';
import 'package:smart_banner/src/widgets/smart_banner_scaffold.dart';

class AdaptiveCloseButton extends StatelessWidget {
  const AdaptiveCloseButton({
    super.key,
    required this.onClose,
  });

  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    final textStyle = SmartBannerTheme.of(context).closeButtonTextStyle;

    return IconButton(
      onPressed: () {
        SmartBannerScaffold.hideBanner(context);
        onClose?.call();
      },
      iconSize: textStyle?.fontSize,
      color: textStyle?.color,
      icon: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: textStyle?.backgroundColor,
        ),
        child: const Icon(Icons.close),
      ),
    );
  }
}

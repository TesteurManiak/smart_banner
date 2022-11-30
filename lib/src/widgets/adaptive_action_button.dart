import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core/banner_style.dart';
import '../theme/theme.dart';

class AdaptiveActionButton extends StatelessWidget {
  const AdaptiveActionButton({
    super.key,
    required this.label,
    required this.style,
    required this.url,
    required this.storeUrl,
  });

  final String label;
  final BannerStyle style;
  final String? url;
  final String storeUrl;

  @override
  Widget build(BuildContext context) {
    final theme = SmartBannerTheme.of(context);
    return TextButton(
      onPressed: _handleOnPressed,
      child: Text(
        label,
        style: theme.buttonTextStyle,
      ),
    );
  }

  Future<void> _handleOnPressed() async {
    final localUrl = url;
    if (localUrl != null) {
      final canLaunch = await canLaunchUrlString(localUrl);
      if (canLaunch) {
        await launchUrlString(localUrl);
      } else {
        await launchUrlString(storeUrl);
      }
    } else {
      await launchUrlString(storeUrl);
    }
  }
}

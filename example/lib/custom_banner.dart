import 'package:flutter/material.dart';
import 'package:smart_banner/smart_banner.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
    required this.properties,
  });

  final BannerProperties properties;

  @override
  Widget build(BuildContext context) {
    final theme = SmartBannerTheme.of(context);
    final author = properties.author;
    final platformProperties = properties.getPlatormProperties(context);

    return Container(
      alignment: Alignment.centerLeft,
      color: theme.backgroundColor,
      child: ListTile(
        leading: platformProperties.icon,
        title: Text(properties.title),
        subtitle: author != null ? Text(author) : null,
        onTap: () {
          properties.onClose?.call();
          SmartBannerScaffold.hideBanner(context);
        },
      ),
    );
  }
}

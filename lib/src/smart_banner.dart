import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../smart_banner.dart';
import 'theme/theme.dart';

const kBannerHeight = 80.0;

class SmartBanner extends StatelessWidget {
  const SmartBanner({
    super.key,
    required this.properties,
    this.style = BannerStyle.adaptive,
  });

  final BannerProperties properties;

  /// Used to enforce a specific style no matter the platform you are on.
  final BannerStyle style;

  @override
  Widget build(BuildContext context) {
    final theme = SmartBannerTheme.of(context);
    final effectiveLang = properties.appStoreLanguage ??
        Localizations.localeOf(context).languageCode;

    return Material(
      color: theme.backgroundColor,
      shadowColor: theme.shadowColor,
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: kBannerHeight,
        width: double.maxFinite,
        child: Row(
          children: [
            _CloseButton(onClose: properties.onClose),
            const SizedBox(width: 5),
            properties.icon,
            const SizedBox(width: 12),
            Expanded(
              child: _TitleAuthorAndStore(
                title: properties.title,
                store: properties.storeText,
                price: properties.priceText,
                author: properties.author,
              ),
            ),
            _ViewButton(
              effectiveLang: effectiveLang,
              label: properties.buttonLabel,
              url: properties.url,
              appId: properties.id,
            ),
          ],
        ),
      ),
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({
    required this.onClose,
  });

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

class _TitleAuthorAndStore extends StatelessWidget {
  const _TitleAuthorAndStore({
    required this.title,
    required this.price,
    required this.store,
    required this.author,
  });

  final String title;
  final PriceText price;
  final StoreText store;
  final String? author;

  @override
  Widget build(BuildContext context) {
    final theme = SmartBannerTheme.of(context);
    final localAuthor = author;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: theme.titleTextStyle,
        ),
        if (localAuthor != null) Text(localAuthor),
        Text('${price.property} - ${store.property}'),
      ],
    );
  }
}

class _ViewButton extends StatelessWidget {
  const _ViewButton({
    required this.effectiveLang,
    required this.label,
    required this.url,
    required this.appId,
  });

  final String effectiveLang;
  final String label;
  final SmartBannerUri? url;
  final SmartBannerId? appId;

  @override
  Widget build(BuildContext context) {
    final theme = SmartBannerTheme.of(context);
    return TextButton(
      onPressed: () {
        launchUrl(_createUri());
      },
      child: Text(
        label,
        style: theme.buttonTextStyle,
      ),
    );
  }

  Uri _createUri() {
    final localUrl = url;
    if (localUrl != null) {
      return localUrl.property;
    }
    return Uri.parse(appId!.createUrl(lang: effectiveLang));
  }
}

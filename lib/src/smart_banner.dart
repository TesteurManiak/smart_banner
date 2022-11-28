import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'banner_properties.dart';
import 'banner_style.dart';
import 'theme.dart';

const _bannerHeight = 80.0;

class SmartBanner extends StatefulWidget implements PreferredSizeWidget {
  const SmartBanner({
    super.key,
    required this.properties,
    this.style = BannerStyle.adaptive,
  });

  final BannerProperties properties;

  /// Used to enforce a specific style no matter the platform you are on.
  final BannerStyle style;

  @override
  State<SmartBanner> createState() => _SmartBannerState();

  @override
  Size get preferredSize => const Size.fromHeight(_bannerHeight);
}

class _SmartBannerState extends State<SmartBanner> {
  @override
  Widget build(BuildContext context) {
    final theme = SmartBannerTheme.of(context);
    final effectiveLang = widget.properties.appStoreLanguage ??
        Localizations.localeOf(context).languageCode;

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: widget.preferredSize.height,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor,
              blurRadius: 2.0,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            _CloseButton(onClose: widget.properties.onClose),
            const SizedBox(width: 5),
            widget.properties.icon,
            const SizedBox(width: 12),
            Expanded(
              child: _TitleAuthorAndStore(
                title: widget.properties.title,
                store: widget.properties.storeText,
                price: widget.properties.priceText,
                author: widget.properties.author,
              ),
            ),
            _ViewButton(
              effectiveLang: effectiveLang,
              label: widget.properties.buttonLabel,
              url: widget.properties.url,
              appId: widget.properties.id,
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
        // TODO: close banner
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

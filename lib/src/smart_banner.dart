import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'smart_banner_properties.dart';
import 'theme.dart';

const _bannerHeight = 80.0;

enum SmartBannerStyle {
  adaptive,
  android,
  ios,
}

class SmartBanner extends StatefulWidget implements PreferredSizeWidget {
  const SmartBanner({
    super.key,
    required this.properties,
    this.style = SmartBannerStyle.adaptive,
  });

  final SmartBannerProperties properties;

  /// Used to enforce a specific style no matter the platform you are on.
  final SmartBannerStyle style;

  @override
  State<SmartBanner> createState() => _SmartBannerState();

  @override
  Size get preferredSize => const Size.fromHeight(_bannerHeight);
}

class _SmartBannerState extends State<SmartBanner> {
  @override
  Widget build(BuildContext context) {
    final effectiveLang = widget.properties.appStoreLanguage ??
        Localizations.localeOf(context).languageCode;

    final SmartBannerThemeData effectiveTheme;
    switch (widget.style) {
      case SmartBannerStyle.adaptive:
        effectiveTheme = SmartBannerThemeData.adaptive();
        break;
      case SmartBannerStyle.android:
        // TODO: check brightness to return dark or light theme
        effectiveTheme = const SmartBannerThemeData.androidDark();
        break;
      case SmartBannerStyle.ios:
        effectiveTheme = const SmartBannerThemeData.ios();
        break;
    }

    return SmartBannerTheme(
      data: effectiveTheme,
      child: Material(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: widget.preferredSize.height,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: effectiveTheme.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: effectiveTheme.shadowColor,
                blurRadius: 2.0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              _CloseButton(onClose: widget.properties.onClose),
              const SizedBox(width: 5),
              const _AppImage(),
              const SizedBox(width: 12),
              Expanded(
                child: _TitleAndStore(
                  title: widget.properties.title,
                  store: widget.properties.storeText,
                  price: widget.properties.priceText,
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

class _AppImage extends StatelessWidget {
  const _AppImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 57,
      width: 57,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

class _TitleAndStore extends StatelessWidget {
  const _TitleAndStore({
    required this.title,
    required this.price,
    required this.store,
  });

  final String title;
  final PriceText price;
  final StoreText store;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title),
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

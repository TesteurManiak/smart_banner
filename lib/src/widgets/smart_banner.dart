import 'package:flutter/material.dart';
import 'package:smart_banner/src/core/banner_properties.dart';
import 'package:smart_banner/src/core/banner_style.dart';
import 'package:smart_banner/src/theme/theme.dart';
import 'package:smart_banner/src/utils/separated_text_span.dart';
import 'package:smart_banner/src/widgets/adaptive_action_button.dart';
import 'package:smart_banner/src/widgets/adaptive_close_button.dart';

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

    final platformProperties = properties.getPropertiesFromStyle(
      context,
      style,
    );

    return Material(
      color: theme.backgroundColor,
      shadowColor: theme.shadowColor,
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: kBannerHeight,
        width: double.maxFinite,
        decoration: style.isAndroid(context)
            ? const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/background.png',
                    package: 'smart_banner',
                  ),
                  repeat: ImageRepeat.repeat,
                ),
              )
            : null,
        child: Row(
          children: [
            AdaptiveCloseButton(onClose: properties.onClose),
            const SizedBox(width: 5),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 57, maxWidth: 57),
              child: platformProperties.icon,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TitleAndDecription(
                title: properties.title,
                store: platformProperties.storeText,
                price: platformProperties.priceText,
                author: properties.author,
              ),
            ),
            AdaptiveActionButton(
              style: style,
              label: properties.buttonLabel,
              url: platformProperties.url,
              storeUrl: platformProperties.createStoreUrl(effectiveLang),
            ),
          ],
        ),
      ),
    );
  }
}

class _TitleAndDecription extends StatelessWidget {
  const _TitleAndDecription({
    required this.title,
    required this.price,
    required this.store,
    required this.author,
  });

  final String title;
  final String? price;
  final String? store;
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
        if (localAuthor != null)
          Text(
            localAuthor,
            style: theme.descriptionTextStyle,
          ),
        Text.rich(
          SeparatedTextSpan(
            separator: const TextSpan(text: ' - '),
            children: [
              if (price != null) TextSpan(text: price),
              if (store != null) TextSpan(text: store),
            ],
          ),
          style: theme.descriptionTextStyle,
        ),
      ],
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'banner_position.dart';
import 'banner_properties.dart';
import 'banner_style.dart';
import 'smart_banner.dart';
import 'theme/theme.dart';
import 'theme/theme_data.dart';
import 'utils/target_platform_extension.dart';

const _kAnimationDuration = Duration(milliseconds: 500);

class SmartBannerScaffold extends StatefulWidget {
  const SmartBannerScaffold({
    super.key,
    required this.child,
    this.position = BannerPosition.top,
    this.style = BannerStyle.adaptive,
    this.animationDuration = _kAnimationDuration,
    this.animationCurve = Curves.easeInOut,
  });

  final Widget child;
  final BannerPosition position;
  final BannerStyle style;
  final Duration animationDuration;
  final Curve animationCurve;

  @override
  State<SmartBannerScaffold> createState() => SmartBannerScaffoldState();

  static SmartBannerScaffoldState of(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<_SmartBannerScope>();
    return inheritedWidget!.state;
  }

  static SmartBannerScaffoldState? maybeOf(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<_SmartBannerScope>();
    return inheritedWidget?.state;
  }

  static void hideBanner(BuildContext context) {
    maybeOf(context)?.hideBanner();
  }

  static void showBanner(BuildContext context) {
    maybeOf(context)?.showBanner();
  }
}

class SmartBannerScaffoldState extends State<SmartBannerScaffold>
    with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: widget.animationDuration,
  );
  late final _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: widget.position == BannerPosition.top
        ? const Offset(0, -1)
        : const Offset(0, 1),
  ).animate(
    CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve,
    ),
  );

  bool get _shouldDisplayBanner {
    if (kDebugMode) return true; // TODO: remove this
    return kIsWeb && defaultTargetPlatform.isSupported;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldDisplayBanner) return widget.child;

    final effectiveTheme = _getEffectiveTheme();
    final children = <Widget>[
      SlideTransition(
        position: _offsetAnimation,
        child: SmartBanner(
          properties: BannerProperties.withUrl(
            title: 'MyPage',
            buttonLabel: 'VIEW',
            storeText: const StoreText(
              onIOS: 'On the App Store',
              onAndroid: 'In Google Play',
            ),
            priceText: const PriceText.fromPrice('Free'),
            url: SmartBannerUri(
              onAndroid: Uri(),
              onIOS: Uri(),
            ),
            icon: const _AppImagePlaceholder(),
          ),
          style: widget.style,
        ),
      ),
      Expanded(
        child: widget.child,
      ),
    ];

    return _SmartBannerScope(
      state: this,
      child: SmartBannerTheme(
        data: effectiveTheme,
        child: Column(
          children: widget.position == BannerPosition.top
              ? children
              : children.reversed.toList(),
        ),
      ),
    );
  }

  SmartBannerThemeData _getEffectiveTheme() {
    switch (widget.style) {
      case BannerStyle.adaptive:
        return SmartBannerThemeData.adaptive();
      case BannerStyle.android:
        // TODO: check brightness to return dark or light theme
        return const SmartBannerThemeData.androidDark();
      case BannerStyle.ios:
        return const SmartBannerThemeData.ios();
    }
  }

  void hideBanner() {
    _animationController.forward();
  }

  void showBanner() {
    _animationController.reverse();
  }
}

class _SmartBannerScope extends InheritedWidget {
  const _SmartBannerScope({
    required this.state,
    required super.child,
  });

  final SmartBannerScaffoldState state;

  @override
  bool updateShouldNotify(_SmartBannerScope oldWidget) {
    return state != oldWidget.state;
  }
}

class _AppImagePlaceholder extends StatelessWidget {
  const _AppImagePlaceholder();

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

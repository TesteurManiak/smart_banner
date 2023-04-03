import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_banner/src/core/banner_position.dart';
import 'package:smart_banner/src/core/banner_properties.dart';
import 'package:smart_banner/src/core/banner_style.dart';
import 'package:smart_banner/src/theme/theme.dart';
import 'package:smart_banner/src/theme/theme_data.dart';
import 'package:smart_banner/src/widgets/smart_banner.dart';

const _kDefaultBannerPosition = BannerPosition.top;
const _kDefaultBannerStyle = BannerStyle.adaptive;
const _kDefaultAnimationDuration = Duration(milliseconds: 300);
const _kDefaultAnimationCurve = Curves.easeInOut;

typedef BannerThemeBuilder = SmartBannerThemeData? Function(
  BuildContext context,
);

typedef BannerBuilder = Widget Function(
  BuildContext context,
  BannerProperties properties,
);

class SmartBannerScaffold extends StatefulWidget {
  const SmartBannerScaffold({
    super.key,
    required this.child,
    required this.properties,
    this.position,
    this.style,
    this.themeBuilder,
    this.bannerBuilder,
    this.animationDuration,
    this.animationCurve,
    this.isShown,
  });

  final Widget child;

  /// Position of the banner.
  ///
  /// Defaults to [BannerPosition.top].
  final BannerPosition? position;

  /// Used to force a specific style.
  ///
  /// Defaults to [BannerStyle.adaptive].
  final BannerStyle? style;

  /// Used to build a custom theme for the banner.
  ///
  /// The theme provided by [style] will be merged inside the one
  /// returned by [themeBuilder].
  final BannerThemeBuilder? themeBuilder;

  /// Used to build a custom banner widget.
  ///
  /// It's height will be constrained to [kBannerHeight].
  final BannerBuilder? bannerBuilder;

  final BannerProperties properties;

  /// Duration of the sliding animation.
  ///
  /// Defaults to 300 milliseconds.
  final Duration? animationDuration;

  /// Curve of the sliding animation.
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve? animationCurve;

  /// Whether the banner should be shown.
  ///
  /// Defaults to [kIsWeb] value.
  final bool? isShown;

  @override
  State<SmartBannerScaffold> createState() => SmartBannerScaffoldState();

  static SmartBannerScaffoldState of(BuildContext context) {
    return maybeOf(context)!;
  }

  static SmartBannerScaffoldState? maybeOf(BuildContext context) {
    final inheritedWidget =
        context.dependOnInheritedWidgetOfExactType<SmartBannerScope>();
    return inheritedWidget?.state;
  }

  /// Shortcut to `SmartBannerScaffold.maybeOf(context).hideBanner()`.
  ///
  /// {@macro smart_banner_scaffold_state.hide_banner}
  static void hideBanner(BuildContext context) {
    maybeOf(context)?.hideBanner();
  }

  /// Shortcut to `SmartBannerScaffold.maybeOf(context).showBanner()`.
  ///
  /// {@macro smart_banner_scaffold_state.show_banner}
  static void showBanner(BuildContext context) {
    maybeOf(context)?.showBanner();
  }
}

class SmartBannerScaffoldState extends State<SmartBannerScaffold>
    with SingleTickerProviderStateMixin {
  late final _offsetTween = Tween<Offset>(
    begin: Offset.zero,
    end: _position.offset,
  );

  AnimationController? _animationController;
  Animation<Offset>? _offsetAnimation;

  bool get _isShown => widget.isShown ?? kIsWeb;
  BannerPosition get _position => widget.position ?? _kDefaultBannerPosition;

  @override
  void initState() {
    super.initState();

    if (_isShown) {
      final animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration ?? _kDefaultAnimationDuration,
      );

      _animationController = animationController;
      _offsetAnimation = _offsetTween.animate(
        CurvedAnimation(
          parent: animationController,
          curve: widget.animationCurve ?? _kDefaultAnimationCurve,
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final offsetAnimation = _offsetAnimation;

    if (!_isShown || offsetAnimation == null) return widget.child;

    final style = widget.style ?? _kDefaultBannerStyle;
    final themeBuilder = widget.themeBuilder;
    final buildTheme = themeBuilder?.call(context);
    final effectiveTheme = buildTheme != null
        ? buildTheme.merge(style.themeFetcher(context))
        : style.themeFetcher(context);

    return SmartBannerScope(
      state: this,
      child: SmartBannerTheme(
        data: effectiveTheme,
        child: _ScaffoldContent(
          position: _position,
          animation: offsetAnimation,
          properties: widget.properties,
          style: style,
          bannerBuilder: widget.bannerBuilder,
          child: widget.child,
        ),
      ),
    );
  }

  /// {@template smart_banner_scaffold_state.hide_banner}
  /// Hide the banner if it was shown.
  ///
  /// If the banner is already hidden, this method does nothing.
  /// {@endtemplate}
  void hideBanner() => _animationController?.forward();

  /// {@template smart_banner_scaffold_state.show_banner}
  /// Show the banner if it was hidden.
  ///
  /// If the banner is already shown, this method does nothing.
  /// {@endtemplate}
  void showBanner() => _animationController?.reverse();
}

@visibleForTesting
class SmartBannerScope extends InheritedWidget {
  const SmartBannerScope({
    super.key,
    required this.state,
    required super.child,
  });

  final SmartBannerScaffoldState state;

  @override
  bool updateShouldNotify(SmartBannerScope oldWidget) {
    return state != oldWidget.state;
  }
}

class _ScaffoldContent extends StatelessWidget {
  const _ScaffoldContent({
    required this.position,
    required this.animation,
    required this.properties,
    required this.style,
    required this.bannerBuilder,
    required this.child,
  });

  final BannerPosition position;
  final Animation<Offset> animation;
  final BannerProperties properties;
  final BannerStyle? style;
  final BannerBuilder? bannerBuilder;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final localBuilder = bannerBuilder;

    final children = <Widget>[
      AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          double offset = kBannerHeight * animation.value.dy;
          if (offset < 0) offset *= -1;
          final height = kBannerHeight - offset;

          return SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: SizedBox(
                height: kBannerHeight,
                child: localBuilder != null
                    ? Material(child: localBuilder(context, properties))
                    : SmartBanner(
                        properties: properties,
                        style: style,
                      ),
              ),
            ),
          );
        },
      ),
      Expanded(child: child),
    ];

    return Column(
      children: [
        ...position == BannerPosition.top ? children : children.reversed
      ],
    );
  }
}

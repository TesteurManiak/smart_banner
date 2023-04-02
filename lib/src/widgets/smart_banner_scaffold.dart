import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smart_banner/src/core/banner_position.dart';
import 'package:smart_banner/src/core/banner_properties.dart';
import 'package:smart_banner/src/core/banner_style.dart';
import 'package:smart_banner/src/theme/theme.dart';
import 'package:smart_banner/src/widgets/smart_banner.dart';

const _kDefaultBannerPosition = BannerPosition.top;
const _kDefaultBannerStyle = BannerStyle.adaptive;
const _kDefaultAnimationDuration = Duration(milliseconds: 300);
const _kDefaultAnimationCurve = Curves.easeInOut;

class SmartBannerScaffold extends StatefulWidget {
  const SmartBannerScaffold({
    super.key,
    required this.child,
    required this.properties,
    this.position,
    this.style,
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
  BannerStyle get _style => widget.style ?? _kDefaultBannerStyle;

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

    final children = <Widget>[
      AnimatedBuilder(
        animation: offsetAnimation,
        builder: (context, _) {
          double offset = kBannerHeight * offsetAnimation.value.dy;
          if (offset < 0) offset *= -1;
          final height = kBannerHeight - offset;

          return SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: SizedBox(
                height: kBannerHeight,
                child: SmartBanner(
                  properties: widget.properties,
                  style: widget.style,
                ),
              ),
            ),
          );
        },
      ),
      Expanded(child: widget.child),
    ];

    return SmartBannerScope(
      state: this,
      child: SmartBannerTheme(
        data: _style.themeFetcher(context),
        child: Column(
          children: _position == BannerPosition.top
              ? children
              : children.reversed.toList(),
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

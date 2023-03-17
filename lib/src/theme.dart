import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class CleanTheme extends StatelessWidget {
  ///ThemeData, just like in the normal Flutter Theme
  final CleanThemeData? data;
  final Widget child;

  const CleanTheme({
    Key? key,
    this.data,
    required this.child,
  }) : super(key: key);

  static CleanThemeData of(BuildContext context) {
    final _InheritedCleanTheme? _inheritedTheme =
        context.dependOnInheritedWidgetOfExactType<_InheritedCleanTheme>();
    //Return a [DefiniteCleanThemeData], defaulting to the default theme if properties are null
    final _theme = Theme.of(context);
    final CleanThemeData? _inherited = _inheritedTheme?.theme.data;

    return CleanThemeData(
      primary: _inherited?.primary ?? _theme.colorScheme.primary,
      onPrimary: _inherited?.onPrimary ?? _theme.colorScheme.onPrimary,
      secondary: _inherited?.secondary ?? _theme.colorScheme.secondary,
      onSecondary: _inherited?.onSecondary ?? _theme.colorScheme.onSecondary,
      elevation: _inherited?.elevation ?? 1,
      interactionMode: _inherited?.interactionMode ?? InteractionMode.splash,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedCleanTheme(theme: this, child: child);
  }
}

class CleanThemeData {
  /// The primary color to be used in all Clean UIX elements
  final Color primary;

  /// A color that's clearly legible when drawn on [primary].
  final Color onPrimary;

  /// The secondary color to be used in all Clean UIX elements
  final Color secondary;

  /// A color that's clearly legible when drawn on [secondary].
  final Color onSecondary;

  final InteractionMode? interactionMode;

  ///The default elevation to use for components
  final double elevation;

  CleanThemeData({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    this.interactionMode,
    this.elevation = 1,
  });
  // : assert(primary == null || onPrimary != null,
  //           "You need to set the onPrimary color as well if you set a primary color."),
  //       assert(secondary == null || onSecondary != null,
  //           "You need to set the onSecondary color as well if you set a secondary color.");

  factory CleanThemeData.from(
    BuildContext context, {
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    InteractionMode? interactionMode = InteractionMode.splash,
    double elevation = 1,
  }) {
    final _theme = Theme.of(context);
    return CleanThemeData(
      primary: primary ?? _theme.colorScheme.primary,
      onPrimary: onPrimary ?? _theme.colorScheme.onPrimary,
      secondary: secondary ?? _theme.colorScheme.secondary,
      onSecondary: onSecondary ?? _theme.colorScheme.onSecondary,
      elevation: elevation,
      interactionMode: interactionMode,
    );
  }
}

///Same as [CleanThemeData], but the properties are non-null
class DefiniteCleanThemeData {
  /// The primary color to be used in all Clean UIX elements
  final Color primary;

  /// A color that's clearly legible when drawn on [primary].
  final Color onPrimary;

  /// The secondary color to be used in all Clean UIX elements
  final Color secondary;

  /// A color that's clearly legible when drawn on [secondary].
  final Color onSecondary;

  final InteractionMode interactionMode;

  ///The default elevation to use for components
  final double elevation;

  ///Same as [CleanThemeData], but the properties are non-null
  DefiniteCleanThemeData({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    this.interactionMode = InteractionMode.splash,
    this.elevation = 1,
  });
}

///What feedback the user gets on interacting with buttons etc.
enum InteractionMode {
  ///Default material splash
  splash,

  ///Opacity of button is changed on click
  opacity,

  ///Scale of button is changed on click
  scale,
}

class _InheritedCleanTheme extends InheritedWidget {
  const _InheritedCleanTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final CleanTheme theme;

  @override
  bool updateShouldNotify(covariant _InheritedCleanTheme oldWidget) =>
      oldWidget.theme.data != theme.data;
}

////
///
///
///
///
/// *** Not really useful anymore ***

class CleanColorScheme {
  /// The primary color to be used in all Clean UIX elements
  final Color? primary;

  /// A color that's clearly legible when drawn on [primary].
  final Color? onPrimary;

  /// The secondary color to be used in all Clean UIX elements
  final Color? secondary;

  /// A color that's clearly legible when drawn on [secondary].
  final Color? onSecondary;

  CleanColorScheme({
    this.primary,
    this.onPrimary,
    this.secondary,
    this.onSecondary,
  })  : assert(primary == null || onPrimary != null,
            "You need to set the onPrimary color as well if you set a primary color."),
        assert(secondary == null || onSecondary != null,
            "You need to set the onSecondary color as well if you set a secondary color.");
}

///Same as [CleanColorScheme], but the properties are non-null
class DefiniteCleanColorScheme {
  /// The primary color to be used in all Clean UIX elements
  final Color primary;

  /// A color that's clearly legible when drawn on [primary].
  final Color onPrimary;

  /// The secondary color to be used in all Clean UIX elements
  final Color secondary;

  /// A color that's clearly legible when drawn on [secondary].
  final Color onSecondary;

  DefiniteCleanColorScheme({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
  });
}

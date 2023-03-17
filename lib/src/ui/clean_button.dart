import 'dart:math';

import 'package:clean_uix/clean_uix.dart';
import 'package:clean_uix/src/helpers/opacity_animator.dart';
import 'package:clean_uix/src/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../helpers/functions.dart';
import '../helpers/statics.dart';

//Inspiration from https://dribbble.com/shots/15025442-Dark-UI-Elements

class CleanButtonStyle extends ButtonStyle {
  const CleanButtonStyle({
    MaterialStateProperty<TextStyle?>? textStyle,
    MaterialStateProperty<Color?>? backgroundColor,
    MaterialStateProperty<Color?>? foregroundColor,
    MaterialStateProperty<Color?>? overlayColor,
    MaterialStateProperty<Color?>? shadowColor,
    MaterialStateProperty<Color?>? surfaceTintColor,
    MaterialStateProperty<double?>? elevation,
    MaterialStateProperty<EdgeInsetsGeometry?>? padding,
    MaterialStateProperty<Size?>? minimumSize,
    MaterialStateProperty<Size?>? fixedSize,
    MaterialStateProperty<Size?>? maximumSize,
    MaterialStateProperty<BorderSide?>? side,
    MaterialStateProperty<OutlinedBorder?>? shape,
    MaterialStateProperty<MouseCursor?>? mouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
  }) : super(
          textStyle: textStyle,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          overlayColor: overlayColor,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          elevation: elevation,
          padding: padding,
          minimumSize: minimumSize,
          fixedSize: fixedSize,
          maximumSize: maximumSize,
          side: side,
          shape: shape,
          mouseCursor: mouseCursor,
          visualDensity: visualDensity,
          tapTargetSize: tapTargetSize,
          animationDuration: animationDuration,
          enableFeedback: enableFeedback,
          alignment: alignment,
          splashFactory: splashFactory,
        );
}

extension CleanThemeDefaults on ButtonStyle? {
  ButtonStyle withDefaults(BuildContext context) {
    final cleanTheme = CleanTheme.of(context);

    return CleanButtonStyle(
      backgroundColor: this?.backgroundColor ??
          MaterialStateProperty.all(cleanTheme.primary),
      foregroundColor: this?.foregroundColor ??
          MaterialStateProperty.all(cleanTheme.onPrimary),
      elevation:
          this?.elevation ?? MaterialStateProperty.all(cleanTheme.elevation),
      shape: this?.shape ?? MaterialStateProperty.all(ButtonStatics.shape),
      padding: this?.padding ??
          MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 17, vertical: 19)),
      //Keep defaults:
      textStyle: this?.textStyle,
      overlayColor: this?.overlayColor,
      shadowColor: this?.shadowColor,
      surfaceTintColor: this?.surfaceTintColor,
      minimumSize: this?.minimumSize,
      fixedSize: this?.fixedSize,
      maximumSize: this?.maximumSize,
      side: this?.side,
      mouseCursor: this?.mouseCursor,
      visualDensity: this?.visualDensity,
      tapTargetSize: this?.tapTargetSize,
      animationDuration: this?.animationDuration,
      enableFeedback: this?.enableFeedback,
      alignment: this?.alignment,
      splashFactory: this?.splashFactory,
    );
  }
}

class CleanButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final InteractionMode? interactionMode;
  final Widget? child;

  final ButtonStyle? style;

  const CleanButton({
    Key? key,
    required this.onPressed,
    // this.primary,
    // this.onPrimary,
    // this.overlayColor,
    this.interactionMode,
    // this.elevation,
    // this.side,
    this.child,
    // this.minimumSize,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = CleanTheme.of(context);
    final _interactionMode = interactionMode ?? _theme.interactionMode;
    final MaterialStateProperty<double?> _elevation = style?.elevation ??
        MaterialStateProperty.all(
            _interactionMode == InteractionMode.opacity ? 0 : _theme.elevation);
    final _isEnabled = onPressed != null;

    //Always returns a buttonStyle, even if style is null
    final buttonStyle = style.withDefaults(context);

    //Color theme
    final _overlayColor = style?.overlayColor ??
        (_interactionMode == InteractionMode.scale
            ? MaterialStateProperty.all(Colors.transparent)
            : null);

    // print("widget: $child, background: ${buttonStyle.backgroundColor}");

    return OpacityAnimator(
      enabled: _interactionMode == InteractionMode.opacity && _isEnabled,
      child: ScaleAnimator(
        enabled: _interactionMode == InteractionMode.scale && _isEnabled,
        child: ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle.copyWith(
            splashFactory: _interactionMode == InteractionMode.splash
                ? null
                : NoSplash.splashFactory,
            overlayColor: _overlayColor,
            backgroundColor: _interactionMode == InteractionMode.scale
                ? MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.hovered)) {
                      return (buttonStyle.backgroundColor
                                  ?.resolve({MaterialState.hovered}) ??
                              _theme.primary)
                          .darken(0.05);
                    }
                    if (_isEnabled) {
                      return buttonStyle.backgroundColor?.resolve(states) ??
                          _theme.primary;
                    }
                  })
                : null,
            //Checking if elevation is null -> if yes, don't do any animation, just set to 0
            elevation: _elevation.resolveWithAll() == 0
                ? const MaterialStatePropertyAll(0)
                : _interactionMode == InteractionMode.scale
                    ? MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.pressed)) {
                          return max(
                              0,
                              (buttonStyle.elevation
                                          ?.resolve({MaterialState.pressed}) ??
                                      _theme.elevation) -
                                  3);
                        } else if (states.contains(MaterialState.hovered)) {
                          return (buttonStyle.elevation
                                      ?.resolve({MaterialState.hovered}) ??
                                  _theme.elevation) +
                              3.7;
                        }
                      })
                    : null,
          ),
          child: child,
        ),
      ),
    );
  }

  factory CleanButton.text(
    String text, {
    Key? key,
    required VoidCallback? onPressed,
    InteractionMode? interactionMode,
    Color? primary,
    Color? onPrimary,
    double? elevation,
    MaterialStateProperty<BorderSide>? side,
    EdgeInsetsGeometry? padding,
  }) {
    return CleanButton(
      onPressed: onPressed,
      interactionMode: interactionMode,
      key: key,
      child: Text(text),
    );
  }

  static ButtonStyle styleFrom({
    Color? foregroundColor,
    Color? backgroundColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
    Color? shadowColor,
    Color? surfaceTintColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    BorderSide? side,
    OutlinedBorder? shape,
    MouseCursor? enabledMouseCursor,
    MouseCursor? disabledMouseCursor,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
    Color? onSurface,
  }) {
    final Color? background = backgroundColor;
    final Color? disabledBackground =
        disabledBackgroundColor ?? onSurface?.withOpacity(0.12);
    final MaterialStateProperty<Color?>? backgroundColorProp =
        (background == null && disabledBackground == null)
            ? null
            : _ElevatedButtonDefaultColor(background, disabledBackground);
    final Color? foreground = foregroundColor;
    final Color? disabledForeground =
        disabledForegroundColor ?? onSurface?.withOpacity(0.38);
    final MaterialStateProperty<Color?>? foregroundColorProp =
        (foreground == null && disabledForeground == null)
            ? null
            : _ElevatedButtonDefaultColor(foreground, disabledForeground);
    final MaterialStateProperty<Color?>? overlayColor =
        (foreground == null) ? null : _ElevatedButtonDefaultOverlay(foreground);
    final MaterialStateProperty<double>? elevationValue =
        (elevation == null) ? null : _ElevatedButtonDefaultElevation(elevation);
    final MaterialStateProperty<MouseCursor?>? mouseCursor =
        (enabledMouseCursor == null && disabledMouseCursor == null)
            ? null
            : _ElevatedButtonDefaultMouseCursor(
                enabledMouseCursor, disabledMouseCursor);

    return ButtonStyle(
      textStyle: MaterialStatePropertyAll<TextStyle?>(textStyle),
      backgroundColor: backgroundColorProp,
      foregroundColor: foregroundColorProp,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(shadowColor),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(surfaceTintColor),
      elevation: elevationValue,
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: ButtonStyleButton.allOrNull<Size>(minimumSize),
      fixedSize: ButtonStyleButton.allOrNull<Size>(fixedSize),
      maximumSize: ButtonStyleButton.allOrNull<Size>(maximumSize),
      side: ButtonStyleButton.allOrNull<BorderSide>(side),
      shape: ButtonStyleButton.allOrNull<OutlinedBorder>(shape),
      mouseCursor: mouseCursor,
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
      splashFactory: splashFactory,
    );
  }

  const factory CleanButton.icon({
    Key? key,
    required VoidCallback? onPressed,
    InteractionMode? interactionMode,
    Widget? icon,
    Widget? child,
    ButtonStyle? style,
  }) = _CleanIconButton;
}

class _CleanIconButton extends CleanButton {
  const _CleanIconButton({
    Key? key,
    VoidCallback? onPressed,
    InteractionMode? interactionMode,
    Widget? icon,
    Widget? child,
    ButtonStyle? style,
  }) : super(
          onPressed: onPressed,
          interactionMode: interactionMode,
          key: key,
          //TODO: Change this so icon + child is placed here
          child: icon,
        );

  @override
  Widget build(BuildContext context) {
    final _theme = CleanTheme.of(context);

    final buttonStyle = style ??
        CleanButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          shape: ButtonStatics.shape,
          minimumSize: const Size(45, 45),
          side: BorderSide(color: _theme.primary, width: 0),
        );

    return CleanButton(
      onPressed: onPressed,
      interactionMode: interactionMode,
      style: buttonStyle,
      key: key,
      child: child,
    );
  }
}

//** Immutables for style **//
@immutable
class _ElevatedButtonDefaultColor extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ElevatedButtonDefaultColor(this.color, this.disabled);

  final Color? color;
  final Color? disabled;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabled;
    }
    return color;
  }
}

@immutable
class _ElevatedButtonDefaultOverlay extends MaterialStateProperty<Color?>
    with Diagnosticable {
  _ElevatedButtonDefaultOverlay(this.overlay);

  final Color overlay;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) {
      return overlay.withOpacity(0.08);
    }
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed)) {
      return overlay.withOpacity(0.24);
    }
    return null;
  }
}

@immutable
class _ElevatedButtonDefaultElevation extends MaterialStateProperty<double>
    with Diagnosticable {
  _ElevatedButtonDefaultElevation(this.elevation);

  final double elevation;

  @override
  double resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return 0;
    }
    if (states.contains(MaterialState.hovered)) {
      return elevation + 2;
    }
    if (states.contains(MaterialState.focused)) {
      return elevation + 2;
    }
    if (states.contains(MaterialState.pressed)) {
      return elevation + 6;
    }
    return elevation;
  }
}

@immutable
class _ElevatedButtonDefaultMouseCursor
    extends MaterialStateProperty<MouseCursor?> with Diagnosticable {
  _ElevatedButtonDefaultMouseCursor(this.enabledCursor, this.disabledCursor);

  final MouseCursor? enabledCursor;
  final MouseCursor? disabledCursor;

  @override
  MouseCursor? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }
}

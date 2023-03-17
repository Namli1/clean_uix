import 'package:flutter/material.dart';

import '../theme.dart';
import './clean_button.dart';

class CleanOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final InteractionMode? interactionMode;
  final Widget? child;
  final double? borderWidth;
  final Color? borderColor;
  final ButtonStyle? style;

  const CleanOutlinedButton({
    Key? key,
    this.style,
    required this.onPressed,
    this.interactionMode,
    this.child,
    this.borderWidth = 1.7,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = CleanTheme.of(context);

    final selectColor = Colors.cyan;
    final isSelected = true;

    final foregroundColor = style?.foregroundColor ??
        MaterialStateProperty.all<Color>(_theme.primary);

    final buttonStyle = (style ?? const ButtonStyle()).copyWith(
      // backgroundColor:
      //     style?.backgroundColor ?? MaterialStatePropertyAll(selectColor),
      // foregroundColor: MaterialStateProperty.resolveWith((states) {
      //   final color =
      //       (style?.foregroundColor?.resolve(states) ?? selectColor[300]);
      //   return (isSelected ? color!.withOpacity(0.45) : Colors.transparent);
      // }),
      // overlayColor: style?.overlayColor ??
      //     style?.foregroundColor ??
      //     MaterialStateProperty.all((selectColor.withOpacity(0.19))),
      // // backgroundColor: style?.foregroundColor ??
      // //     const MaterialStatePropertyAll(Colors.transparent),
      // // ??
      // //     MaterialStateProperty.all<Color>(_theme.onPrimary),
      elevation: const MaterialStatePropertyAll(0),
      // foregroundColor: style?.foregroundColor ??
      //     const MaterialStatePropertyAll(Colors.transparent),
      foregroundColor: foregroundColor,
      backgroundColor: style?.backgroundColor ??
          MaterialStateProperty.all<Color>(Colors.transparent),
      overlayColor: style?.overlayColor ??
          //style?.backgroundColor ??
          MaterialStateProperty.resolveWith(
              (states) => foregroundColor.resolve(states)?.withOpacity(0.19)),
      // overlayColor: MaterialStateProperty.resolveWith((states) {
      //   if (states.contains(MaterialState.hovered)) {
      //     return Colors.transparent;
      //   } else if (states.contains(MaterialState.focused)) {
      //     return Colors.transparent;
      //   } else {
      //     return Colors.cyanAccent;
      //   }
      // }),
      // ??
      //     MaterialStateProperty.all<Color>(_theme.primary),
      side: style?.side ??
          (borderWidth != null
              ? MaterialStateProperty.resolveWith((states) => BorderSide(
                  color: borderColor ?? Colors.grey[400]!.withOpacity(0.9),
                  width: borderWidth!))
              : null),
      //splashFactory: InkSplash.splashFactory,
    );

    return CleanButton(
      onPressed: onPressed,
      style: buttonStyle,
      interactionMode: interactionMode,
      child: child,
    );
  }
}

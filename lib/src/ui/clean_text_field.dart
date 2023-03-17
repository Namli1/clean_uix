import 'package:clean_uix/clean_uix.dart';
import 'package:flutter/material.dart';

class CleanTextField extends StatelessWidget {
  final TextEditingController? controller;

  final EdgeInsetsGeometry outerPadding;
  final EdgeInsetsGeometry? contentPadding;

  ///Color for the border.
  ///
  ///Note that the border color has a default opacity. Change this opacity with
  ///the parameters [borderOpacity] and [focusedBorderOpacity]
  final Color? borderColor;

  ///Color for the border when focused
  final Color? focusedBorderColor;
  final Color? backgroundColor;
  final TextStyle? style;
  final String? label;
  final TextStyle? labelStyle;
  final String? hintText;
  final BorderRadius? borderRadius;

  final bool autoFocus;

  ///Width for the border, defaults to [1.5]
  final double? borderWidth;

  ///Default opacity for the border color, default is [0.33]
  final double? borderOpacity;

  ///Opacity for the border color when focused, default is [0.63]
  final double? focusedBorderOpacity;

  ///Width for the border when focused, defaults to [1.9]
  final double? focusedBorderWidth;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  //Callbacks
  final VoidCallback? onEditingComplete;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final void Function()? onTap;

  const CleanTextField({
    Key? key,
    this.controller,
    this.outerPadding = const EdgeInsets.symmetric(vertical: 9, horizontal: 17),
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 19, vertical: 3),
    this.borderColor,
    this.focusedBorderColor,
    this.backgroundColor,
    this.label,
    this.labelStyle,
    this.hintText,
    this.borderRadius,
    this.borderWidth,
    this.focusedBorderWidth,
    this.borderOpacity,
    this.focusedBorderOpacity,
    this.style,
    this.prefixIcon,
    this.suffixIcon,
    this.autoFocus = false,
    this.onEditingComplete,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
  })  : assert(
            borderOpacity != null
                ? borderOpacity >= 0 && borderOpacity <= 1
                : true,
            "Opacity can only have values between 0 and 1!"),
        assert(
            focusedBorderOpacity != null
                ? focusedBorderOpacity >= 0 && focusedBorderOpacity <= 1
                : true,
            "Opacity can only have values between 0 and 1!"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = CleanTheme.of(context);
    final _borderRadius = borderRadius ?? BorderRadius.circular(11);
    final _borderColor = borderColor ?? Colors.grey[800];

    return Padding(
      padding: outerPadding,
      // decoration: BoxDecoration(boxShadow: [
      //   const BoxShadow(
      //     color: Colors.yellow,
      //     blurRadius: 1,
      //     spreadRadius: 1,
      //   ),
      // ]),
      child: TextField(
        controller: controller,
        cursorColor: _theme.primary,
        style: style,
        autofocus: autoFocus,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTap: onTap,
        decoration: InputDecoration(
          filled: backgroundColor != null,
          fillColor: backgroundColor,
          contentPadding: contentPadding,
          labelText: label,
          floatingLabelStyle: labelStyle ?? TextStyle(color: _theme.primary),
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: _borderRadius,
            borderSide: BorderSide(
                color: _borderColor!.withOpacity(borderOpacity ?? 0.33)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: _borderRadius,
            borderSide: BorderSide(
              width: borderWidth ?? 1.5,
              color: _borderColor.withOpacity(borderOpacity ?? 0.33),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: _borderRadius,
            borderSide: BorderSide(
              width: focusedBorderWidth ?? borderWidth ?? 1.9,
              color: focusedBorderColor?.withOpacity(
                      focusedBorderOpacity ?? borderOpacity ?? 0.63) ??
                  _borderColor.withOpacity(
                      focusedBorderOpacity ?? borderOpacity ?? 0.63),
            ),
          ),
        ),
      ),
    );
  }

  factory CleanTextField.filled({
    Key? key,
    EdgeInsetsGeometry outerPadding =
        const EdgeInsets.symmetric(vertical: 9, horizontal: 17),
    EdgeInsetsGeometry? contentPadding =
        const EdgeInsets.symmetric(horizontal: 19, vertical: 3),
    Color? borderColor,
    Color? backgroundColor,
    String? label,
    TextStyle? labelStyle,
    String? hintText,
    Color? focusedBorderColor,
    double? focusedBorderWidth,
    BorderRadius? borderRadius,
    double? borderWidth,
    TextStyle? style,

    ///Default opacity for the border color
    double? borderOpacity,

    ///Opacity for the border color when focused
    double? focusedBorderOpacity,
  }) {
    return CleanTextField(
      backgroundColor: backgroundColor ?? Colors.grey[350],
      borderColor: borderColor ?? Colors.grey[350],
      focusedBorderColor: focusedBorderColor ?? borderColor ?? Colors.grey,
      focusedBorderWidth: focusedBorderWidth,
      borderOpacity: borderOpacity,
      focusedBorderOpacity: focusedBorderOpacity,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      contentPadding: contentPadding,
      hintText: hintText,
      key: key,
      label: label,
      labelStyle: labelStyle,
      outerPadding: outerPadding,
      style: style,
    );
  }
}

class _FilledCleanTextField extends CleanTextField {
  _FilledCleanTextField({
    Key? key,
    EdgeInsetsGeometry outerPadding =
        const EdgeInsets.symmetric(vertical: 9, horizontal: 17),
    EdgeInsetsGeometry? contentPadding =
        const EdgeInsets.symmetric(horizontal: 19, vertical: 3),
    Color? borderColor,
    Color? backgroundColor,
    String? label,
    TextStyle? labelStyle,
    String? hintText,
  }) : super(
          key: key,
          backgroundColor: backgroundColor ?? Colors.grey[100],
          contentPadding: contentPadding,
          borderColor: borderColor,
          label: label,
          labelStyle: labelStyle,
          hintText: hintText,
          outerPadding: outerPadding,
        );
}

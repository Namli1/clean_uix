import 'package:clean_uix/clean_uix.dart';
import 'package:flutter/material.dart';

///Inspiration from https://dribbble.com/shots/15137093--Notifications-New-Countly-UI

class CleanToast extends StatelessWidget {
  final Color primary;
  final Color onPrimary;
  final Border? border;
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;
  final Widget? icon;
  final bool showCloseButton;
  final Widget? closeIcon;
  final VoidCallback? onClosePressed;

  const CleanToast({
    Key? key,
    this.primary = Colors.red,
    this.onPrimary = Colors.white,
    this.border,
    this.child,
    this.leading,
    this.trailing,
    this.icon,
    this.showCloseButton = true,
    this.closeIcon,
    this.onClosePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: primary.withOpacity(0.23),
          border: Border.all(color: primary),
          boxShadow: [
            BoxShadow(
              color: primary.withOpacity(0.07),
              blurRadius: 10,
              spreadRadius: 10,
            )
          ]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: leading ??
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15),
                        color: primary,
                        boxShadow: [
                          BoxShadow(
                            color: primary.withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ]),
                    child: IconTheme(
                      data: IconTheme.of(context).copyWith(color: onPrimary),
                      child: icon ??
                          const Icon(
                            Icons.warning,
                          ),
                    ),
                  )),
          if (child != null) const SizedBox(width: 13),
          if (child != null)
            Flexible(
              child: child!,
            ),
          if (child != null) const SizedBox(width: 21),
          if (child == null) const SizedBox(width: 7),
          if (showCloseButton || trailing != null)
            Flexible(
                child: trailing ??
                    CleanOutlinedButton(
                      onPressed: onClosePressed,
                      borderWidth: null,
                      child: closeIcon ??
                          const Icon(
                            Icons.close,
                          ),
                    )),
        ],
      ),
    );
  }

  factory CleanToast.text(
    String text, {
    TextStyle? textStyle,
    Color primary = Colors.red,
    Color onPrimary = Colors.white,
    Border? border,
    Widget? leading,
    Widget? trailing,
    Widget? icon,
    bool showCloseButton = true,
    Widget? closeIcon,
    VoidCallback? onClosePressed,
  }) {
    return CleanToast(
      onPrimary: onPrimary,
      primary: primary,
      border: border,
      leading: leading,
      trailing: trailing,
      icon: icon,
      showCloseButton: showCloseButton,
      closeIcon: closeIcon,
      onClosePressed: onClosePressed,
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}

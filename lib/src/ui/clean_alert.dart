import 'package:clean_uix/clean_uix.dart';
import 'package:flutter/material.dart';

//Inspiration from https://dribbble.com/shots/16083490-Pop-Up-Overlay

class CleanAlert extends StatelessWidget {
  final Widget? child;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? padding;
  final bool showCloseButton;
  final Color? backgroundColor;
  final VoidCallback? onClosePressed;
  final BoxBorder? border;

  CleanAlert({
    Key? key,
    this.child,
    this.constraints = const BoxConstraints(minHeight: 133, minWidth: 300),
    this.padding = const EdgeInsets.all(17),
    this.showCloseButton = true,
    this.backgroundColor,
    this.onClosePressed,
    this.border = const Border.symmetric(),
  }) : super(key: key);

  double _childRotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    final _theme = CleanTheme.of(context);
    final _materialTheme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
              decoration: BoxDecoration(
                border: border == null
                    ? null
                    : (border == const Border.symmetric()
                        ? Border.all(color: _theme.primary)
                        : border),
                borderRadius: BorderRadius.circular(33),
                color: backgroundColor ?? _materialTheme.colorScheme.surface,
              ),
              constraints: constraints,
              padding: padding,
              child: Transform.rotate(
                angle: _childRotationAngle,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Padding(
                      padding: showCloseButton
                          ? const EdgeInsets.only(top: 19)
                          : EdgeInsets.zero,
                      child: child ?? Container(),
                    ),
                    if (showCloseButton)
                      Positioned.directional(
                        textDirection: TextDirection.ltr,
                        end: 0,
                        top: 0,
                        child: CleanOutlinedButton(
                          borderWidth: null,
                          onPressed: onClosePressed ??
                              () => Navigator.of(context).pop(),
                          style: CleanButton.styleFrom(
                              padding: EdgeInsets.zero,
                              foregroundColor: Colors.black),
                          child: const Icon(Icons.close),
                        ),
                      ),
                  ],
                ),
              )),
        ),
      ],
    );
  }

  Widget rotate({
    Border? border,
    BorderRadius? borderRadius,
    double transformAngle = -0.03,
    Color? lineBorderColor = Colors.white60,
  }) {
    _childRotationAngle = -transformAngle;
    return _RotatedWidget(
      child: this,
      border: border,
      borderRadius: borderRadius,
      transformAngle: transformAngle,
      lineBorderColor: lineBorderColor,
    );
  }

  factory CleanAlert.simpleText({
    Key? key,
    String? title,
    String? subtitle,
    String? text,
    Widget? topIcon,
    Widget? bottomWidget,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? padding = const EdgeInsets.all(17),
    bool showCloseButton = true,
    Color? backgroundColor,
    VoidCallback? onClosePressed,
  }) {
    return CleanAlert.simple(
      backgroundColor: backgroundColor,
      constraints: constraints,
      key: key,
      onClosePressed: onClosePressed,
      padding: padding,
      showCloseButton: showCloseButton,
      child: _SimpleCleanAlertChild(
        titleText: title,
        subtitleText: subtitle,
        text: text,
        topIcon: topIcon,
        bottomWidget: bottomWidget,
      ),
    );
  }

  factory CleanAlert.simple({
    Key? key,
    Widget? title,
    Widget? subtitle,
    Widget? child,
    Widget? topIcon,
    Widget? bottomWidget,
    BoxConstraints? constraints,
    EdgeInsetsGeometry? padding,
    bool showCloseButton,
    Color? backgroundColor,
    VoidCallback? onClosePressed,
  }) = _SimpleCleanAlert;
}

class _RotatedWidget extends StatelessWidget {
  final Widget? child;
  final BoxBorder? border;
  final BorderRadius? borderRadius;
  final double transformAngle;
  final Color? lineBorderColor;

  _RotatedWidget({
    Key? key,
    this.child,
    this.border,
    this.borderRadius,
    this.transformAngle = 0.03,
    this.lineBorderColor,
  }) : super(key: key);

  final GlobalKey _key = GlobalKey();
  // late final Size? _size =
  //     (_key.currentContext?.findRenderObject() as RenderBox).size;

  @override
  Widget build(BuildContext context) {
    final _theme = CleanTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: border ??
                Border.all(color: lineBorderColor ?? _theme.primary, width: 2),
            borderRadius: borderRadius ?? BorderRadius.circular(33),
          ),
          child: Transform.rotate(
            angle: transformAngle,
            child: child ?? Container(),
          ),
        ),
      ],
    );
  }
}

class _SimpleCleanAlert extends CleanAlert {
  _SimpleCleanAlert({
    Key? key,
    Widget? title,
    Widget? subtitle,
    Widget? child,
    Widget? topIcon,
    Widget? bottomWidget,
    BoxConstraints? constraints =
        const BoxConstraints(minHeight: 133, minWidth: 300),
    EdgeInsetsGeometry? padding = const EdgeInsets.all(17),
    bool showCloseButton = true,
    Color? backgroundColor,
    VoidCallback? onClosePressed,
  }) : super(
            backgroundColor: backgroundColor,
            padding: padding,
            constraints: constraints,
            onClosePressed: onClosePressed,
            showCloseButton: showCloseButton,
            child: _SimpleCleanAlertChild(
              title: title,
              subtitle: subtitle,
              bottomWidget: bottomWidget,
              key: key,
              topIcon: topIcon,
              child: child,
            ));
}

class _SimpleCleanAlertChild extends StatelessWidget {
  final String? titleText;
  final Widget? title;
  final String? subtitleText;
  final Widget? subtitle;
  final String? text;
  final Widget? child;
  final Widget? topIcon;
  final Widget? bottomWidget;

  const _SimpleCleanAlertChild({
    Key? key,
    this.title,
    this.titleText,
    this.subtitleText,
    this.subtitle,
    this.text,
    this.child,
    this.topIcon,
    this.bottomWidget,
  })  : assert(title == null || titleText == null,
            "Please either set title or titleText"),
        assert(subtitle == null || subtitleText == null,
            "Please either set subtitle or subtitleText"),
        assert(
            text == null || child == null, "Please either set text or child"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _materialTheme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (topIcon != null) topIcon!,
        if (titleText != null)
          Text(
            titleText!,
            style: _materialTheme.textTheme.headline4,
          )
        else if (title != null)
          title!,
        if (subtitleText != null)
          Text(
            subtitleText!,
            style: _materialTheme.textTheme.subtitle2,
          )
        else if (subtitle != null)
          subtitle!,
        if (text != null) Text(text!) else if (child != null) child!,
        if (bottomWidget != null) bottomWidget!,
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CleanListItem extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry titlePadding;

  final Widget? title;
  final Widget? overline;

  ///Divider between the overline and the title
  final Widget? overlineDivider;

  final Widget? subtitle;

  ///Divider between the subtitle and the title
  final Widget? subtitleDivider;
  final Widget? leading;
  final Widget? trailing;

  ///Easily set a title text if you only need text.
  ///Default style is [TextTheme.headline4]
  ///
  ///But you can't set both [title] and [titleText]
  final String? titleText;

  ///Easily set an overline text if you only need text.
  ///Default style is [TextTheme.overline]
  ///
  ///But you can't set both [overline] and [overlineText]
  final String? overlineText;

  ///Easily set a subtitle text if you only need text
  ///Default style is [TextTheme.subtitle1]
  ///
  ///But you can't set both [subtitle] and [subtitleText]
  final String? subtitleText;

  const CleanListItem({
    Key? key,
    this.margin,
    this.padding = const EdgeInsets.all(5),
    this.titlePadding = const EdgeInsets.symmetric(horizontal: 7),
    this.border,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.title,
    this.overline,
    this.leading,
    this.trailing,
    this.subtitle,
    this.overlineDivider,
    this.subtitleDivider,
    this.titleText,
    this.overlineText,
    this.subtitleText,
  })  : assert(overline == null || overlineText == null,
            "Please only set either overline or overlineText"),
        assert(title == null || titleText == null,
            "Please only set either title or titleText"),
        assert(subtitle == null || subtitleText == null,
            "Please only set either subtitle or subtitleText"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _materialTheme = Theme.of(context);

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: border,
      ),
      child: Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (leading != null) Flexible(child: leading!),
          Expanded(
            child: Padding(
              padding: titlePadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (overline != null)
                    overline!
                  else if (overlineText != null)
                    Text(
                      overlineText!,
                      style: _materialTheme.textTheme.overline,
                    ),
                  if (overlineDivider != null) overlineDivider!,
                  if (title != null)
                    title!
                  else if (titleText != null)
                    Text(
                      titleText!,
                      style: _materialTheme.textTheme.headline4,
                    ),
                  if (subtitleDivider != null) subtitleDivider!,
                  if (subtitle != null)
                    subtitle!
                  else if (subtitleText != null)
                    Text(
                      subtitleText!,
                      style: _materialTheme.textTheme.subtitle2,
                    ),
                ],
              ),
            ),
          ),
          if (trailing != null) Flexible(child: trailing!),
        ],
      ),
    );
  }
}

import 'package:clean_uix/clean_uix.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

typedef AttachedWidgetCallback = void Function({
  required Widget Function(VoidCallback cancel, bool isSticky) builder,
  Color? backgroundColor,
  EdgeInsetsGeometry modalPadding,
  EdgeInsetsGeometry stickyPadding,
  BoxConstraints? modalConstraints,
  ShapeBorder? modalShape,
  BorderRadius stickyBorderRadius,
  PreferDirection? stickyPreferDirection,
  VoidCallback? stickyOnClose,
  Duration? stickyAnimationDuration,
  double stickyHorizontalOffset,
  double stickyVerticalOffset,
  List<BoxShadow>? stickyShadow,
  bool? alwaysSticky,
});

class CleanStickyPanel extends StatelessWidget {
  const CleanStickyPanel({
    super.key,
    required this.builder,
  });

  //The outer widget triggering the panel
  final Widget Function(BuildContext context, AttachedWidgetCallback show)
      builder;

  void show(
    BuildContext targetContext, {
    required Widget Function(VoidCallback cancel, bool isSticky) childBuilder,
    Color? backgroundColor,
    EdgeInsetsGeometry modalPadding =
        const EdgeInsets.only(top: 33, right: 33, left: 33),
    EdgeInsetsGeometry stickyPadding = const EdgeInsets.all(17),
    BoxConstraints? modalConstraints = const BoxConstraints(maxWidth: 900),
    ShapeBorder? modalShape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23))),
    BorderRadius stickyBorderRadius =
        const BorderRadius.all(Radius.circular(17)),
    PreferDirection? stickyPreferDirection,
    VoidCallback? stickyOnClose,
    Duration? stickyAnimationDuration,
    double stickyHorizontalOffset = 10.0,
    double stickyVerticalOffset = 10.0,
    List<BoxShadow>? stickyShadow,
    bool? alwaysSticky,
  }) {
    //Determine device dimensions
    final bool _isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;
    final _screenSize = MediaQuery.of(targetContext).size.width;
    final _showSticky = alwaysSticky ?? (_isDesktop ? true : _screenSize > 600);

    print(alwaysSticky);

    if (_showSticky) {
      BotToast.showAttachedWidget(
        targetContext: targetContext,
        preferDirection: stickyPreferDirection,
        onClose: stickyOnClose,
        animationDuration: stickyAnimationDuration,
        horizontalOffset: stickyHorizontalOffset,
        verticalOffset: stickyVerticalOffset,
        attachedBuilder: (cancelFunc) {
          final theme = Theme.of(targetContext);
          return CleanTheme(
            data: CleanTheme.of(targetContext),
            child: Container(
              padding: stickyPadding,
              decoration: BoxDecoration(
                color: backgroundColor ?? theme.colorScheme.surface,
                borderRadius: stickyBorderRadius,
                boxShadow: stickyShadow ??
                    [
                      BoxShadow(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                          blurRadius: 7)
                    ],
              ),
              child: childBuilder.call(cancelFunc, _showSticky),
              // TextButton(
              //   child: Text("Click me here!"),
              //   onPressed: () {},
              // ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: targetContext,
        shape: modalShape,
        constraints: modalConstraints,
        backgroundColor: backgroundColor,
        builder: (context) {
          return CleanTheme(
            data: CleanTheme.of(targetContext),
            child: Padding(
                padding: modalPadding,
                child: childBuilder.call(
                    () => Navigator.of(context).pop(), _showSticky)),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return builder.call(
          context,
          ({
            required Widget Function(VoidCallback cancel, bool isSticky)
                builder,
            Color? backgroundColor,
            EdgeInsetsGeometry modalPadding = const EdgeInsets.all(33),
            EdgeInsetsGeometry stickyPadding = const EdgeInsets.all(17),
            BoxConstraints? modalConstraints =
                const BoxConstraints(maxWidth: 900),
            ShapeBorder? modalShape = const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(23))),
            BorderRadius stickyBorderRadius =
                const BorderRadius.all(Radius.circular(17)),
            PreferDirection? stickyPreferDirection,
            VoidCallback? stickyOnClose,
            Duration? stickyAnimationDuration,
            double stickyHorizontalOffset = 10.0,
            double stickyVerticalOffset = 10.0,
            List<BoxShadow>? stickyShadow,
            bool? alwaysSticky,
          }) =>
              show(
            context,
            childBuilder: builder,
            alwaysSticky: alwaysSticky,
            backgroundColor: backgroundColor,
            modalConstraints: modalConstraints,
            modalPadding: modalPadding,
            modalShape: modalShape,
            stickyAnimationDuration: stickyAnimationDuration,
            stickyBorderRadius: stickyBorderRadius,
            stickyHorizontalOffset: stickyHorizontalOffset,
            stickyOnClose: stickyOnClose,
            stickyPadding: stickyPadding,
            stickyPreferDirection: stickyPreferDirection,
            stickyShadow: stickyShadow,
            stickyVerticalOffset: stickyVerticalOffset,
          ),
        );
      },
    );
  }
}

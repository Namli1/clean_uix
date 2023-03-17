import 'dart:developer';

import 'package:clean_uix/clean_uix.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

///Displays a floating modal on mobile devices and an alert dialog on desktop devices (by default)
///You can customize this behaviour by settings [showAlert] to true/false. Leaving it null will apply the custom logic.
class CleanFloatingPanel {
  static void present(
    BuildContext context, {
    required Widget Function(BuildContext context) builder,
    bool? showAlert,
    BorderRadius? borderRadius,
    bool modalIsDismissible = true,
    bool modalEnableDrag = true,
    bool modalShouldExpand = false,
    Widget? buttonBar = const DefaultButtonBar(),
    EdgeInsets padding =
        const EdgeInsets.only(top: 0, bottom: 17, right: 17, left: 17),
    EdgeInsets modalMargin =
        const EdgeInsets.symmetric(vertical: 23, horizontal: 17),
  }) {
    ///Determine device dimension
    final bool _isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;
    final _screenSize = MediaQuery.of(context).size.width;
    final _showAlert = showAlert ?? _isDesktop || _screenSize > 900;

    if (_showAlert) {
      showDialog(
        context: context,
        builder: (ctx) {
          return CleanTheme(
              //We have to pass the theme again because in a modal/dialog the context is different
              //So the original theme can't be accessed
              data: CleanTheme.of(context),
              child: AlertDialog(
                contentPadding: padding,
                titlePadding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                title: buttonBar,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(17),
                ),
                content: Builder(builder: builder),
              ));
        },
      );
    } else {
      showCustomModalBottomSheet(
          context: context,
          builder: (ctx) {
            if (buttonBar != null) {
              // return DraggableScrollableSheet(
              //   expand: false,
              //   builder: (context, scrollController) {
              return CleanTheme(
                  //We have to pass the theme again because in a modal/dialog the context is different
                  //So the original theme can't be accessed
                  data: CleanTheme.of(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //controller: scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 15),
                        child: buttonBar,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              borderRadius ?? BorderRadius.circular(17),
                        ),
                        child: Builder(
                          builder: builder,
                        ),
                      ),
                    ],
                  ));
            } else {
              return CleanTheme(
                  //We have to pass the theme again because in a modal/dialog the context is different
                  //So the original theme can't be accessed
                  data: CleanTheme.of(context),
                  child: Builder(
                    builder: builder,
                  ));
            }
          },
          enableDrag: modalEnableDrag,
          isDismissible: modalIsDismissible,
          expand: modalShouldExpand,
          containerWidget: (ctx, _1, child) {
            return SafeArea(
              minimum: modalMargin,
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  borderRadius: borderRadius ?? BorderRadius.circular(17),
                  color: Colors.white,
                ),
                child: child,
              ),
            );
          });
    }
  }

  static void flow(
    BuildContext context, {
    required List<
            Widget Function(
                BuildContext context, void Function({int index}) next)>
        builders,
    VoidCallback? onReachedEnd,
    int initialIndex = 0,
    bool? showAlert,
    BorderRadius? borderRadius,
    bool modalIsDismissible = true,
    bool modalEnableDrag = true,
    bool modalShouldExpand = false,
    Widget? buttonBar = const DefaultButtonBar(),
    EdgeInsets padding =
        const EdgeInsets.only(top: 0, bottom: 17, right: 17, left: 17),
    EdgeInsets modalMargin =
        const EdgeInsets.symmetric(vertical: 23, horizontal: 17),
  }) {
    ///Determine device dimension
    final bool _isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;
    final _screenSize = MediaQuery.of(context).size.width;
    final _showAlert = showAlert ?? _isDesktop || _screenSize > 900;

    if (_showAlert) {
      showDialog(
        context: context,
        builder: (context) {
          return CleanTheme(
              //We have to pass the theme again because in a modal/dialog the context is different
              //So the original theme can't be accessed
              data: CleanTheme.of(context),
              child: AlertDialog(
                contentPadding: padding,
                titlePadding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 17),
                title: buttonBar,
                shape: RoundedRectangleBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(17),
                ),
                content: AnimatedFlow(
                  builders: builders,
                  initialIndex: initialIndex,
                  onReachedEnd: onReachedEnd,
                ),
              ));
        },
      );
    } else {
      showCustomModalBottomSheet(
          context: context,
          builder: (ctx) {
            if (buttonBar != null) {
              // return DraggableScrollableSheet(
              //   expand: false,
              //   builder: (context, scrollController) {
              return CleanTheme(
                  //We have to pass the theme again because in a modal/dialog the context is different
                  //So the original theme can't be accessed
                  data: CleanTheme.of(context),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    //controller: scrollController,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 15),
                        child: buttonBar,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                borderRadius ?? BorderRadius.circular(17),
                          ),
                          child: AnimatedFlow(
                            builders: builders,
                            onReachedEnd: onReachedEnd,
                            initialIndex: initialIndex,
                          )),
                    ],
                  ));
            } else {
              return CleanTheme(
                  //We have to pass the theme again because in a modal/dialog the context is different
                  //So the original theme can't be accessed
                  data: CleanTheme.of(context),
                  child: AnimatedFlow(
                    builders: builders,
                    onReachedEnd: onReachedEnd,
                    initialIndex: initialIndex,
                  ));
            }
          },
          enableDrag: modalEnableDrag,
          isDismissible: modalIsDismissible,
          expand: modalShouldExpand,
          containerWidget: (ctx, _1, child) {
            return SafeArea(
              minimum: modalMargin,
              child: Container(
                padding: padding,
                decoration: BoxDecoration(
                  borderRadius: borderRadius ?? BorderRadius.circular(17),
                  color: Colors.white,
                ),
                child: child,
              ),
            );
          });
    }
  }
}

class AnimatedFlow extends StatefulWidget {
  final List<
      Widget Function(
          BuildContext context, void Function({int index}) next)> builders;
  final VoidCallback? onReachedEnd;
  final int initialIndex;

  const AnimatedFlow({
    Key? key,
    required this.builders,
    this.onReachedEnd,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<AnimatedFlow> createState() => _AnimatedFlowState();
}

class _AnimatedFlowState extends State<AnimatedFlow> {
  late int _currentIndex = widget.initialIndex;

  void next({int? index}) {
    if (index != null && index < widget.builders.length) {
      setState(() {
        _currentIndex = index;
      });
    } else if (index != null && index >= widget.builders.length) {
      log("[CleanFloatingPanel.flow]Index out of range, there are not enough builders.");
    } else if (_currentIndex < widget.builders.length - 1) {
      setState(() {
        _currentIndex += 1;
      });
    } else {
      widget.onReachedEnd?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
        duration: const Duration(milliseconds: 500),
        child: Builder(
          builder: (context) =>
              widget.builders[_currentIndex].call(context, next),
        ));
  }
}

class DefaultButtonBar extends StatelessWidget {
  const DefaultButtonBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CleanOutlinedButton(
          style: CleanButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              side: BorderSide(
                  color: Colors.grey[400]!.withOpacity(0.9), width: 1.3),
              minimumSize: const Size(40, 40),
              padding: const EdgeInsets.all(7)),
          child: const Icon(Icons.close),
          onPressed: (() => Navigator.pop(context)),
        ),
      ],
    );
  }
}

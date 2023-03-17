import 'dart:math';

import 'package:clean_uix/clean_uix.dart';

import '../helpers/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CleanPanel {
  ///Show a panel from the bottom (on mobile) or from the side (on desktop or big screens)
  ///
  ///* Use the [showSidePanel] parameter to set a custom logic for when to show the side panel.
  ///Or set to [true/false] to always/never show the side panel.
  ///* [sidePanelWidth] is a callback that passes the current screenWidth as an argument
  ///* Set a bar with buttons or other widgets by using [buttonBar].
  ///It will be a footer on the side panel and on top for the modal bottom sheet
  static void present(
    BuildContext context, {
    required Widget Function(BuildContext context) builder,
    BoxConstraints? modalConstraints = const BoxConstraints(maxWidth: 900),
    ShapeBorder? modalShape = const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23))),
    bool modalIsScrollControlled = false,
    Color? modalBackgroundColor,
    bool modalEnableDrag = true,
    Clip? modalClipBehavior,
    double? modalElevation,
    bool? showSidePanel,
    double Function(double)? sidePanelWidth,
    double height = double.infinity,
    bool isDismissible = true,
    String? sidePanelbarrierLabel = "Side panel",
    Color? barrierColor,
    Widget? buttonBar,
    Color? sidePanelButtonBarBackgroundColor,
    bool useRootNavigator = true,
  }) {
    //Determine device dimensions
    final bool _isDesktop = defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.linux;
    final _screenSize = MediaQuery.of(context).size.width;
    final _showSidePanel = showSidePanel ?? _isDesktop || _screenSize > 900;

    if (!_showSidePanel) {
      showModalBottomSheet(
          context: context,
          constraints: modalConstraints,
          shape: modalShape,
          isDismissible: isDismissible,
          barrierColor: barrierColor,
          isScrollControlled: modalIsScrollControlled,
          backgroundColor: modalBackgroundColor,
          enableDrag: modalEnableDrag,
          clipBehavior: modalClipBehavior,
          elevation: modalElevation,
          useRootNavigator: useRootNavigator,
          builder: (_) {
            if (buttonBar != null) {
              // return DraggableScrollableSheet(
              //   expand: false,
              //   builder: (context, scrollController) {
              return CleanTheme(
                //We have to pass the theme again because in a modal/dialog the context is different
                //So the original theme can't be accessed
                data: CleanTheme.of(context),
                child: Column(
                  //controller: scrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 9, vertical: 15),
                      child: buttonBar,
                    ),
                    Expanded(
                        child: Builder(
                      builder: builder,
                    )),
                  ],
                ),
              );
              //   },
              // );
            } else {
              return Builder(builder: builder);
            }
          });
    } else {
      /// Inspiration from https://github.com/lalitjarwal/modal_side_sheet/blob/master/lib/src/modal_side_sheet.dart
      final _width =
          sidePanelWidth?.call(_screenSize) ?? max(_screenSize * 0.5, 300);
      // if (sidePanelWidth == null) {
      //   if (_screenSize < 900) {
      //     sidePanelWidth = _screenSize * 0.25;
      //   } else {
      //     sidePanelWidth = _screenSize * 0.6;
      //   }
      // }
      final _materialTheme = Theme.of(context);
      showGeneralDialog(
        context: context,
        barrierDismissible: isDismissible,
        barrierLabel: sidePanelbarrierLabel,
        barrierColor: barrierColor ?? const Color(0x80000000),
        useRootNavigator: useRootNavigator,
        pageBuilder: (context, _, __) {
          return CleanTheme(
              //We have to pass the theme again because in a modal/dialog the context is different
              //So the original theme can't be accessed
              data: CleanTheme.of(context),
              child: Align(
                alignment: Alignment.centerRight,
                child: Material(
                    child: SizedBox(
                  width: _width,
                  height: height,
                  child: buttonBar != null
                      ? Stack(
                          children: [
                            Builder(builder: builder),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                color: sidePanelButtonBarBackgroundColor ??
                                    _materialTheme.colorScheme.surface
                                        .darken(0.05),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 9, vertical: 15),
                                  child: buttonBar,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Builder(builder: builder),
                )),
              ));
        },
        transitionBuilder: (_, animation, __, child) {
          return SlideTransition(
              child: child,
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(animation));
        },
      );
    }
  }
}

class _ButtonBar extends StatelessWidget {
  final MainAxisAlignment alignment;
  final List<Widget>? children;

  const _ButtonBar(
      {Key? key, this.alignment = MainAxisAlignment.end, this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 15),
      child: SizedBox(
        height: 100,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: children ?? [],
        ),
      ),
    );
  }
}

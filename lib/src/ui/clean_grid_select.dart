import 'dart:isolate';

import 'package:clean_uix/clean_uix.dart';
import 'package:flutter/material.dart';

import '../helpers/functions.dart';

// ///Grid Select to select one or multiple of defined options.
// ///
// ///As this is a grid, when you place it in a column/row/etc, you have to either:
// ///* wrap it in a Flexible/Expanded widget
// ///* or use shrinkwrap
// class CleanGridSelect2 extends StatefulWidget {
//   const CleanGridSelect2({
//     Key? key,
//     this.options,
//     this.onSelect,
//     this.multiSelect = false,
//     //this.primaryColor,
//     this.selectColor = Colors.green,
//     this.validator,
//     this.onSaved,
//     this.interactionMode,
//     this.gridMaxColumnCount = 4,
//     this.gridSensitivity = 1,
//     this.childAspectRatio = 3.7 / 1,
//     this.shrinkWrap = false,
//     this.itemBuilder,
//     this.childBuilder,
//     this.childShape,
//   })  : assert(gridSensitivity >= 0 && gridSensitivity <= 1,
//             "Must be between 0 and 1"),
//         assert(options == null || itemBuilder == null,
//             "Can't have both options and an itemBuilder, only one property will work at one time."),
//         super(key: key);

//   final List<GridSelectOption>? options;
//   final Function(List<GridSelectOption>? selected)? onSelect;
//   final bool multiSelect;
//   final String? Function(List<GridSelectOption>?)? validator;
//   final void Function(List<GridSelectOption>?)? onSaved;
//   final InteractionMode? interactionMode;

//   // ///Primary color for text
//   // final Color? primaryColor;

//   ///Select color for the buttons
//   final MaterialColor selectColor;

//   ///Shape for the [CleanButton] child
//   ///
//   ///Will be overridden by [itemBuilder]
//   final OutlinedBorder? childShape;

//   ///Controls how many maximum columns there are in the responsive grid
//   final int gridMaxColumnCount;

//   ///From GridView: The ratio of the cross-axis to the main-axis extent of each child.
//   final double childAspectRatio;

//   ///Custom gridDelegate, will override [options] and [childShape]
//   final Widget Function(
//           BuildContext context, int index, void Function(int index) didSelect)?
//       itemBuilder;

//   ///Custom builder for the child inside the button
//   final Widget Function(BuildContext context, int index)? childBuilder;

//   ///Controls how sensitive the grid is when resizing to be responsive
//   ///
//   ///Must be a value between 0 and 1
//   final double gridSensitivity;
//   final bool shrinkWrap;

//   @override
//   _CleanGridSelect2State createState() => _CleanGridSelect2State();

//   factory CleanGridSelect2.builder(
//     Widget Function(BuildContext context, int index,
//             void Function(int index) didSelect)?
//         itemBuilder, {
//     Function(List<GridSelectOption>? selected)? onSelect,
//     bool multiSelect = false,
//     //this.primaryColor,
//     MaterialColor selectColor = Colors.green,
//     final String? Function(List<GridSelectOption>?)? validator,
//     void Function(List<GridSelectOption>?)? onSaved,
//     InteractionMode? interactionMode,
//     int gridMaxColumnCount = 4,
//     double gridSensitivity = 1,
//     double childAspectRatio = 3.7 / 1,
//     bool shrinkWrap = false,
//   }) {
//     return CleanGridSelect2(
//       onSelect: onSelect,
//       itemBuilder: itemBuilder,
//       onSaved: onSaved,
//       validator: validator,
//     );
//   }
// }

// class _CleanGridSelect2State extends State<CleanGridSelect2> {
//   //late List<GridSelectOption> _localOptions = widget.options ?? [];

//   // List<GridSelectOption> get selectedOptions {
//   //   TextFormField();
//   //   return _localOptions.where((option) => option.isSelected == true).toList();
//   // }

//   late final List<GridSelectOption> _localOptions = widget.options ?? [];

//   @override
//   Widget build(BuildContext context) {
//     final _theme = CleanTheme.of(context);
//     final _materialTheme = Theme.of(context);

//     return FormField<List<GridSelectOption>>(
//       validator: widget.validator,
//       onSaved: widget.onSaved,
//       builder: (state) {
//         void didSelect(int index) {
//           if (widget.multiSelect) {
//             setState(() {
//               _localOptions[index].isSelected =
//                   !_localOptions[index].isSelected;
//             });
//             state.didChange(_localOptions
//                 .where((option) => option.isSelected == true)
//                 .toList());
//           } else {
//             final _wasSelected = _localOptions[index].isSelected;
//             _localOptions.forEach((option) => option.isSelected = false);
//             setState(() {
//               _localOptions[index].isSelected = !_wasSelected;
//             });
//             state.didChange(_localOptions
//                 .where((option) => option.isSelected == true)
//                 .toList());
//           }
//           widget.onSelect?.call(state.value);
//         }

//         return LayoutBuilder(builder: (context, constraints) {
//           return Column(
//             //mainAxisSize: MainAxisSize.min,
//             children: [
//               Expanded(
//                 flex: widget.shrinkWrap ? 0 : 1,
//                 child: GridView.builder(
//                     shrinkWrap: widget.shrinkWrap,
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: responsiveGridColumnCount(
//                             constraints.maxWidth,
//                             widget.gridMaxColumnCount,
//                             widget.gridSensitivity),
//                         childAspectRatio: widget.childAspectRatio,
//                         crossAxisSpacing: 10,
//                         mainAxisSpacing: 10),
//                     itemCount: widget.options?.length ?? 0,
//                     itemBuilder: widget.itemBuilder != null
//                         ? (context, index) =>
//                             widget.itemBuilder!.call(context, index, didSelect)
//                         : (context, index) {
//                             final option = _localOptions[index];

//                             return CleanOutlinedButton(
//                                 onPressed: () => didSelect(index),
//                                 interactionMode: widget.interactionMode,
//                                 shape: widget.childShape,
//                                 side:
//                                     MaterialStateProperty.resolveWith((states) {
//                                   if (option.isSelected) {
//                                     return BorderSide(
//                                         color: widget.selectColor, width: 2.3);
//                                   }
//                                   if (states.contains(MaterialState.hovered)) {
//                                     return BorderSide(
//                                         color:
//                                             widget.selectColor.withOpacity(0.5),
//                                         width: 2);
//                                   }
//                                   return BorderSide(
//                                       width: 1.9,
//                                       color: widget.selectColor[400]!
//                                           .withOpacity(0.9));
//                                 }),
//                                 //primary: _theme.primary,
//                                 overlayColor:
//                                     widget.selectColor.withOpacity(0.19),
//                                 backgroundColor: option.isSelected
//                                     ? widget.selectColor[300]!.withOpacity(0.45)
//                                     : Colors.transparent,
//                                 padding: EdgeInsets.zero,
//                                 child:
//                                     widget.childBuilder?.call(context, index) ??
//                                         option.child);
//                           }),
//               ),
//             ],
//           );
//         });

//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Expanded(
//               child: LayoutBuilder(builder: (context, constraints) {
//                 return SliverGrid(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: responsiveGridColumnCount(
//                           constraints.maxWidth,
//                           widget.gridMaxColumnCount,
//                           widget.gridSensitivity),
//                       childAspectRatio: widget.childAspectRatio,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10),
//                   delegate: SliverChildBuilderDelegate((context, index) {
//                     final option = _localOptions[index];

//                     return CleanOutlinedButton(
//                       onPressed: () => didSelect(index),
//                       interactionMode: widget.interactionMode,
//                       side: MaterialStateProperty.resolveWith((states) {
//                         if (option.isSelected) {
//                           return const BorderSide(
//                               color: Colors.green, width: 2.3);
//                         }
//                         if (states.contains(MaterialState.hovered)) {
//                           return const BorderSide(
//                               color: Colors.green, width: 2);
//                         }
//                         return BorderSide(
//                             width: 1.9,
//                             color: Colors.grey[400]!.withOpacity(0.9));
//                       }),
//                       primary: _theme.primary,
//                       backgroundColor: option.isSelected
//                           ? Colors.green[300]!.withOpacity(0.37)
//                           : Colors.transparent,
//                       child: option.child,
//                       // Row(
//                       //   mainAxisSize: MainAxisSize.min,
//                       //   children: [
//                       //     Flexible(child: option.child),
//                       //   ],
//                       // ),
//                     );
//                   }),
//                 );
//               }),
//             ),
//             // LayoutBuilder(builder: (context, constraints) {
//             //   return GridView.builder(
//             //       itemCount: _localOptions.length,
//             //       physics: const NeverScrollableScrollPhysics(),
//             //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             //           crossAxisCount: responsiveGridColumnCount(
//             //               constraints.maxWidth,
//             //               widget.gridMaxColumnCount,
//             //               widget.gridSensitivity),
//             //           childAspectRatio: 3.7 / 1,
//             //           crossAxisSpacing: 10,
//             //           mainAxisSpacing: 10),
//             //       itemBuilder: (context, index) {
//             //         final option = _localOptions[index];

//             //         return CleanOutlinedButton(
//             //           onPressed: () => didSelect(index),
//             //           interactionMode: widget.interactionMode,
//             //           side: MaterialStateProperty.resolveWith((states) {
//             //             if (option.isSelected) {
//             //               return const BorderSide(
//             //                   color: Colors.green, width: 2.3);
//             //             }
//             //             if (states.contains(MaterialState.hovered)) {
//             //               return const BorderSide(
//             //                   color: Colors.green, width: 2);
//             //             }
//             //             return BorderSide(
//             //                 width: 1.9,
//             //                 color: Colors.grey[400]!.withOpacity(0.9));
//             //           }),
//             //           primary: _theme.primary,
//             //           backgroundColor: option.isSelected
//             //               ? Colors.green[300]!.withOpacity(0.37)
//             //               : Colors.transparent,
//             //           // style: ButtonStyle(
//             //           //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
//             //           //       borderRadius: BorderRadius.circular(17))),
//             //           //   // side: MaterialStateProperty.resolveWith((states) {
//             //           //   //   if (option.isSelected) {
//             //           //   //     return const BorderSide(
//             //           //   //         color: Colors.green, width: 2.3);
//             //           //   //   }
//             //           //   //   if (states.contains(MaterialState.hovered)) {
//             //           //   //     return const BorderSide(
//             //           //   //         color: Colors.green, width: 2);
//             //           //   //   }
//             //           //   //   return BorderSide(
//             //           //   //       width: 1.9,
//             //           //   //       color: Colors.grey[400]!.withOpacity(0.9));
//             //           //   // }),
//             //           //   foregroundColor:
//             //           //       MaterialStateColor.resolveWith((states) {
//             //           //     //if (option.isSelected) return Colors.green[300]!;
//             //           //     return widget.primaryColor ??
//             //           //         _materialTheme.colorScheme.onBackground
//             //           //             .withOpacity(0.7);
//             //           //   }),
//             //           //   backgroundColor:
//             //           //       MaterialStateColor.resolveWith((states) {
//             //           //     if (option.isSelected)
//             //           //       return Colors.green[300]!.withOpacity(0.37);
//             //           //     return Colors.transparent;
//             //           //     // return widget.primaryColor ??
//             //           //     //     _theme.colorScheme.onBackground.withOpacity(0.7);
//             //           //   }),
//             //           //),
//             //           child: Row(
//             //             mainAxisSize: MainAxisSize.min,
//             //             children: [
//             //               Flexible(child: Text(option.title, maxLines: 1)),
//             //               if (option.icon != null)
//             //                 Flexible(child: option.icon!),
//             //             ],
//             //           ),
//             //         );
//             //       });
//             // }),
//             state.hasError
//                 ? Padding(
//                     padding: const EdgeInsets.only(top: 9),
//                     child: Text(
//                       state.errorText ??
//                           "Something's wrong with this selection 🤔, there was an error.",
//                       style: TextStyle(color: _materialTheme.colorScheme.error),
//                     ),
//                   )
//                 : Container()
//           ],
//         );
//       },
//     );
//   }
// }

class GridSelectOption<T> {
  final Widget child;

  ///Value to uniquely identify this option.
  ///
  ///But be careful not to set the same value for two GridSelectOption's because this will mess with the equality check
  ///and you might get strange results
  final T? value;
  bool isSelected;
  final ButtonStyle? buttonStyle;
  final MaterialColor? selectColor;

  GridSelectOption({
    required this.child,
    required this.value,
    this.isSelected = false,
    this.buttonStyle,
    this.selectColor,
  });

  factory GridSelectOption.text(
    String text, {
    Widget? icon,
    T? value,
    bool isSelected = false,
    int maxLines = 1,
    ButtonStyle? buttonStyle,
    MaterialColor? selectColor,
  }) {
    return GridSelectOption(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(text, maxLines: maxLines),
          ),
          if (icon != null) Flexible(child: icon),
        ],
      ),
      value: value,
      isSelected: isSelected,
      buttonStyle: buttonStyle,
      selectColor: selectColor,
    );
  }

  ///We have to override equal operator
  ///Because when we have an option builder, a new GridSelectOption instance is created everytime
  ///So they are never equal
  ///But we need GridSelectOption's with same option and child to be treated as equal
  ///So this needs to be overriden
  @override
  bool operator ==(Object other) {
    return other is GridSelectOption &&
        //child == other.child &&
        value == other.value;
    // &&
    // isSelected == other.isSelected;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return "$value - isSelected: $isSelected";
  }
}

class CleanGridSelect<T> extends _BasicGridSelect<T> {
  CleanGridSelect({
    super.key,
    super.validator,
    super.multiSelect,
    super.onSaved,
    super.shrinkWrap,
    super.gridSensitivity,
    super.gridMaxColumnCount,
    super.onSelect,
    super.childAspectRatio,
    List<GridSelectOption<T>> options = const [],
    InteractionMode? interactionMode,
    OutlinedBorder? childShape,
    MaterialColor selectColor = Colors.green,
    bool isEnabled = true,
  }) : super(
          itemBuilder: (context, index, didSelect, isSelected) {
            return _CleanGridSelectButton(
              option: options[index],
              isSelected: isSelected.call(options[index]),
              interactionMode: interactionMode,
              childShape: childShape,
              selectColor: options[index].selectColor ?? selectColor,
              onPressed:
                  isEnabled ? () => didSelect.call(options[index]) : null,
              style: options[index].buttonStyle,
            );
          },
          itemCount: options.length,
        );

  //TODO: Do itemBuilder for replacing the whole button widget itself
  //Problem is that you have to pass the option itself to the widget but then you would be passing yourself

  ///Builder to replace to whole button itself
  // CleanGridSelect.builder(
  //     {super.key,
  //     super.shrinkWrap,
  //     required GridSelectOption Function(
  //             BuildContext context,
  //             void Function(GridSelectOption option) didSelect,
  //             bool Function(GridSelectOption option) isSelected)
  //         optionBuilder,
  //     int? itemCount})
  //     : super(
  //           itemBuilder: (context, _, didSelect, isSelected) {
  //             final option = optionBuilder.call(context, (selected) => option, isSelected);
  //             return option.child;
  //           },
  //           itemCount: itemCount);

  ///Builder for the child of the button
  ///
  ///**IMPORTANT**: Be sure to pass in a **unique** value to the GridSelectOption in the builder
  CleanGridSelect.builder({
    super.key,
    super.shrinkWrap,
    super.onSelect,
    int? optionCount,
    super.gridMaxColumnCount,
    super.childAspectRatio,
    super.gridSensitivity,
    super.multiSelect,
    super.onSaved,
    super.validator,
    required GridSelectOption<T> Function(BuildContext context, int index)
        optionBuilder,
    InteractionMode? interactionMode,
    OutlinedBorder? childShape,
    MaterialColor selectColor = Colors.green,
    bool isEnabled = true,
  }) : super(
          itemCount: optionCount,
          itemBuilder: (context, index, didSelect, isSelected) {
            final option = optionBuilder.call(context, index);
            return _CleanGridSelectButton(
              option: option,
              isSelected: isSelected.call(option),
              interactionMode: interactionMode,
              childShape: childShape,
              selectColor: option.selectColor ?? selectColor,
              onPressed: isEnabled ? () => didSelect.call(option) : null,
              style: option.buttonStyle,
            );
          },
        );

  CleanGridSelect.cleanButtons({
    super.key,
    super.shrinkWrap,
    super.onSelect,
    int? optionCount,
    super.gridMaxColumnCount,
    super.childAspectRatio,
    super.gridSensitivity,
    super.multiSelect,
    super.onSaved,
    super.validator,
    InteractionMode? interactionMode,
    required GridSelectOption<T> Function(BuildContext context, int index)
        optionBuilder,
    MaterialColor selectColor = Colors.green,
  }) : super(
          itemCount: optionCount,
          itemBuilder: (context, index, didSelect, isSelected) {
            final option = optionBuilder.call(context, index);
            final cleanTheme = CleanTheme.of(context);

            return CleanButton(
              child: option.child,
              //option: option,
              //isSelected: index == 2 ? true : false,//isSelected.call(option),
              interactionMode: interactionMode,
              //selectColor: option.selectColor ?? selectColor,
              onPressed: () => didSelect.call(option),
              style: (option.buttonStyle ?? const ButtonStyle()).copyWith(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (isSelected.call(option)) {
                  return selectColor;
                } else {
                  return option.buttonStyle?.backgroundColor?.resolve(states) ??
                      cleanTheme.primary;
                }
              })),
            );
          },
        );
}

///Basic Grid Select Skeleton, use CleanGridSelect for widget use
class _BasicGridSelect<T> extends StatefulWidget {
  const _BasicGridSelect({
    Key? key,
    //this.options,
    this.onSelect,
    this.multiSelect = false,
    //this.primaryColor,
    this.validator,
    this.onSaved,
    this.gridMaxColumnCount = 4,
    this.gridSensitivity = 1,
    this.childAspectRatio = 3.7 / 1,
    this.shrinkWrap = false,
    this.itemBuilder,
    this.itemCount,
  }) :
        // assert(gridSensitivity >= 0 && gridSensitivity <= 1,
        //           "Must be between 0 and 1"),
        // assert(options == null || itemBuilder == null,
        //     "Can't have both options and an itemBuilder, only one property will work at one time."),
        super(key: key);

  final Function(Set<GridSelectOption<T>>? selected, Set<T?>? selectedValues)?
      onSelect;
  final bool multiSelect;
  final String? Function(Set<GridSelectOption<T>>?)? validator;
  final void Function(Set<GridSelectOption<T>>?)? onSaved;

  ///Controls how many maximum columns there are in the responsive grid
  final int gridMaxColumnCount;

  ///From GridView: The ratio of the cross-axis to the main-axis extent of each child.
  final double childAspectRatio;

  ///Custom itemBuilder
  ///
  ///Call the [didSelect] function when option is selected.
  ///
  ///Call the [isSelected] function to check if option is selected.
  final Widget Function(
      BuildContext context,
      int index,
      void Function(GridSelectOption<T> selected) didSelect,
      bool Function(GridSelectOption<T> option) isSelected)? itemBuilder;

  ///Item count for items
  final int? itemCount;

  ///Controls how sensitive the grid is when resizing to be responsive
  ///
  ///Must be a value between 0 and 1
  final double gridSensitivity;
  final bool shrinkWrap;

  @override
  State<_BasicGridSelect<T>> createState() => __BasicGridSelectState<T>();
}

class __BasicGridSelectState<T> extends State<_BasicGridSelect<T>> {
  //late final List<GridSelectOption> _localOptions = [];
  late Set<GridSelectOption<T>> _selected = {};

  ///Check wether option is selected
  bool isSelected(GridSelectOption option) {
    return _selected.contains(option);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = CleanTheme.of(context);
    final _materialTheme = Theme.of(context);

    return FormField<Set<GridSelectOption<T>>>(
        validator: widget.validator,
        onSaved: widget.onSaved,
        builder: (state) {
          // void didSelectIndex(int index) {
          //   if (indexIsSelected(index)) {
          //     //If option is already selected
          //     //Deselect it
          //     setState(() {
          //       _selectedIndeces.remove(index);
          //     });
          //     state.didChange(_selected);
          //   }
          // }

          void didSelect(GridSelectOption<T> selected) {
            if (isSelected(selected)) {
              //If option is already selected
              //Deselect it
              setState(() {
                _selected.remove(selected);
              });
              state.didChange(_selected);
            } else if (widget.multiSelect) {
              setState(() {
                _selected.add(selected);
              });
              state.didChange(_selected);
              // Get indexes of true values
              // final selectedOptions = _selectedList
              //     .asMap()
              //     .entries
              //     .where((element) => element.value == true)
              //     .map<int>((e) => e.key)
              //     .toList();
              // _selectedList.indexWhere((element) => false);
              // state.didChange(selectedOptions.map<GridSelectOption>((e) => e.)
              //     .where((option) => option.isSelected == true)
              //     .toList());
            } else {
              //Not multi-select:
              setState(() {
                _selected = {selected};
              });
              state.didChange(_selected);

              // final _wasSelected = _selectedList[index];
              // //Setting all to false
              // for (int i = 0; i < _selectedList.length; i++) {
              //   _selectedList[i] = false;
              // }
              // //Setting only one option as selected
              // setState(() {
              //   _selectedList[index] = !_wasSelected;
              // });
              // // state.didChange(_localOptions
              // //     .where((option) => option.isSelected == true)
              // //     .toList());
            }
            final selectedValues =
                state.value?.map((e) => e.value).whereType<T>().toSet();
            widget.onSelect?.call(state.value, selectedValues);
          }

          return LayoutBuilder(builder: (context, constraints) {
            return GridView.builder(
              shrinkWrap: widget.shrinkWrap,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: responsiveGridColumnCount(
                      constraints.maxWidth,
                      widget.gridMaxColumnCount,
                      widget.gridSensitivity),
                  childAspectRatio: widget.childAspectRatio,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: widget.itemCount,
              itemBuilder: (context, index) => widget.itemBuilder!
                  .call(context, index, didSelect, isSelected),
            );
          });
          // LayoutBuilder(builder: (context, constraints) {
          //   return Column(
          //     //mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Expanded(
          //         flex: widget.shrinkWrap ? 0 : 1,
          //         child: GridView.builder(
          //             shrinkWrap: widget.shrinkWrap,
          //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: responsiveGridColumnCount(
          //                     constraints.maxWidth,
          //                     widget.gridMaxColumnCount,
          //                     widget.gridSensitivity),
          //                 childAspectRatio: widget.childAspectRatio,
          //                 crossAxisSpacing: 10,
          //                 mainAxisSpacing: 10),
          //             itemCount: widget.itemCount,
          //             itemBuilder: widget.itemBuilder != null
          //                 ? (context, index) => widget.itemBuilder!
          //                     .call(context, index, didSelect)
          //                 : (context, index) {
          //                     //final option = _localOptions[index];

          //                     return _CleanGridSelectButton(
          //                       option: GridSelectOption.text("Test"),
          //                     );
          //                   }),
          //       ),
          //     ],
          //   );
          // });
        });
  }
}

class _CleanGridSelectButton extends StatelessWidget {
  const _CleanGridSelectButton({
    Key? key,
    required this.option,
    this.interactionMode,
    this.selectColor = Colors.green,
    this.childShape,
    this.onPressed,
    this.child,
    this.isSelected = false,
    this.style,
  }) : super(key: key);

  final GridSelectOption option;

  final bool isSelected;

  final InteractionMode? interactionMode;

  final VoidCallback? onPressed;

  ///Select color for the buttons
  final MaterialColor selectColor;

  ///Shape for the [CleanButton] child
  final OutlinedBorder? childShape;

  ///Custom child, will override [option.child]
  final Widget? child;

  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return CleanOutlinedButton(
        onPressed: onPressed,
        interactionMode: interactionMode,
        style: (style ?? const ButtonStyle())
            // CleanButton.styleFrom(
            //         shape: childShape,
            //         backgroundColor:
            //             (isSelected
            //                 ? (style?.backgroundColor ?? selectColor[300])!.withOpacity(0.45)
            //                 : Colors.transparent),
            //         foregroundColor: style?.foregroundColor,
            //         padding: EdgeInsets.zero)
            .copyWith(
          shape:
              childShape != null ? MaterialStateProperty.all(childShape) : null,
          foregroundColor:
              style?.foregroundColor ?? MaterialStatePropertyAll(selectColor),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            final color =
                (style?.backgroundColor?.resolve(states) ?? selectColor[300]);
            return (isSelected ? color!.withOpacity(0.45) : Colors.transparent);
          }),
          side: MaterialStateProperty.resolveWith((states) {
            final _selectColor =
                style?.backgroundColor?.resolve(states) ?? selectColor;
            if (isSelected) {
              return BorderSide(color: _selectColor, width: 2.3);
            }
            if (states.contains(MaterialState.hovered)) {
              return BorderSide(color: _selectColor.withOpacity(0.5), width: 2);
            }
            return BorderSide(
                width: 1.9,
                color: (style?.backgroundColor?.resolve(states) ??
                        selectColor[400])!
                    .withOpacity(0.9));
          }),
          elevation: const MaterialStatePropertyAll(0),
          overlayColor: style?.overlayColor ??
              style?.backgroundColor ??
              MaterialStateProperty.all((selectColor.withOpacity(0.19))),
        ),
        child: child ?? option.child);
  }
}

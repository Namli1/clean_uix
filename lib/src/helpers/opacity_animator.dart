import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OpacityAnimator extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  final double animateToOpacity;
  final bool enabled;

  const OpacityAnimator({
    Key? key,
    this.child,
    this.duration = const Duration(milliseconds: 180),
    this.animateToOpacity = 0.4,
    this.enabled = true,
  })  : assert(animateToOpacity >= 0.0 && animateToOpacity <= 1.0,
            "Opacity can only be a value between 0 and 1."),
        super(key: key);

  @override
  State<OpacityAnimator> createState() => _OpacityAnimatorState();
}

class _OpacityAnimatorState extends State<OpacityAnimator> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return widget.enabled
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) => setState(() => _isPressed = false),
            onTapCancel: () => setState(() => _isPressed = false),
            child: AnimatedOpacity(
              opacity: _isPressed ? widget.animateToOpacity : 1,
              duration: widget.duration,
              child: widget.child,
              curve: Curves.easeInOutCubicEmphasized,
            ),
          )
        : Container(child: widget.child);
  }
}

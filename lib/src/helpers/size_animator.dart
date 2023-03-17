import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///Animates the size of the child widget on click
class ScaleAnimator extends StatefulWidget {
  final Widget? child;
  final double scaleDownTo;
  final bool enabled;

  const ScaleAnimator({
    Key? key,
    this.child,
    this.scaleDownTo = 0.91,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<ScaleAnimator> createState() => _ScaleAnimatorState();
}

class _ScaleAnimatorState extends State<ScaleAnimator>
    with TickerProviderStateMixin {
  static const Duration kScaleDownDuration = Duration(milliseconds: 120);
  static const Duration kScaleUpDuration = Duration(milliseconds: 180);
  late final Tween<double> _scaleTween =
      Tween<double>(begin: 1.0, end: widget.scaleDownTo);

  late final AnimationController _animationController;
  late final Animation<double> _scaleTransition;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _scaleTransition = _animationController
        .drive(CurveTween(curve: Curves.easeInExpo))
        .drive(_scaleTween);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails details) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0,
            duration: kScaleDownDuration, curve: Curves.easeInOut)
        : _animationController.animateTo(0.0,
            duration: kScaleUpDuration, curve: Curves.easeOutSine);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) _animate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.enabled
        ? GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: ScaleTransition(
              scale: _scaleTransition,
              child: widget.child,
            ),
          )
        : Container(
            child: widget.child,
          );
  }
}

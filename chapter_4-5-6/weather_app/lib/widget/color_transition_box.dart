import 'package:flutter/material.dart';

class ColorTransitionBox extends AnimatedWidget {
  final Widget child;

  ColorTransitionBox({
    required this.child,
    Key? key,
    required Animation<Color?> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<Color?> animation = listenable as Animation<Color?>;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: animation.value,
      ),
      child: child,
    );
  }
}
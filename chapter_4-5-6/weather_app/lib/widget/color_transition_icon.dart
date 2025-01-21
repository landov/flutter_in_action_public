import 'package:flutter/material.dart';

class ColorTransitionIcon extends AnimatedWidget {
  final IconData icon;
  final double size;

  ColorTransitionIcon({
    required this.icon,
    required this.size,
    Key? key,
    required Animation<Color?> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<Color?> animation = listenable as Animation<Color?>;
    return Icon(
      icon,
      color: animation.value,
      size: size,
    );
  }
}
import 'package:flutter/material.dart';

class ColorTransitionText extends AnimatedWidget {
  final String text;
  final TextStyle style;

  ColorTransitionText({
    required this.text,
    required this.style,
    Key? key,
    required Animation<Color?> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<Color?> animation = listenable as Animation<Color?>;
    return Text(
      text,
      style: style.copyWith(color: animation.value),
    );
  }
}
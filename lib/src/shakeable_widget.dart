import 'package:flutter/material.dart';

/// ShakeableWidget extends AnimatedWidget and is designed to update the UI 
/// based on the provided Animation value. This widget is typically used to 
/// create a shaking effect or similar animations by leveraging the animation 
/// framework in Flutter.
class ShakeableWidget extends AnimatedWidget {
  final Widget child;

  const ShakeableWidget({
    super.key,
    required Animation<double> animation,
    required this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(offset: Offset(animation.value, 0), child: child);
  }
}

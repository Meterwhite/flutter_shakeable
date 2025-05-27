import 'package:flutter/material.dart';
import 'package:flutter_shakeable/src/shakeable_vsync.dart';
import 'shakeable_widget.dart';

/// Shakeable is a class that enables any Widget to have a left-right shaking animation.
/// It uses Flutter's AnimationController and TweenSequence to achieve the shaking effect.
/// The `+` operator is overridden, allowing it to combine directly with a Widget and return a ShakeableWidget.
class Shakeable {
  Shakeable({
    this.duration = const Duration(milliseconds: 500),
    this.shakes = 3,
    this.shakeOffset = 10.0,
  }) {
    _controller = AnimationController(
      duration: duration,
      vsync: _vsyncDelegate,
    );
    // Use TweenSequence to construct keyframe animations for left-right shaking
    _animation = TweenSequence<double>(_buildTweenItems()).animate(_controller);
  }

  /// Total duration of the animation
  final Duration duration;

  /// Number of shakes, which determines the number of left-right half cycles
  final int shakes;

  /// Maximum amplitude for left-right shaking (in pixels)
  final double shakeOffset;

  final ShakeableVsync _vsyncDelegate = ShakeableVsync();

  late final AnimationController _controller;

  late final Animation<double> _animation;

  /// Build a list of TweenSequenceItem based on the configuration
  List<TweenSequenceItem<double>> _buildTweenItems() {
    final List<TweenSequenceItem<double>> items = [];

    // Construct keyframes: start at 0, alternate between left and right offsets, and finally return to 0
    final List<double> keyframes = [0];
    for (int i = 0; i < shakes * 2; i++) {
      keyframes.add(i % 2 == 0 ? -shakeOffset : shakeOffset);
    }
    keyframes.add(0);

    final int segments = keyframes.length - 1;
    final double segmentWeight = 1.0 / segments;
    for (int i = 0; i < segments; i++) {
      items.add(
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: keyframes[i], end: keyframes[i + 1]),
          weight: segmentWeight,
        ),
      );
    }
    return items;
  }

  /// Start the shaking animation, always playing from 0
  void shake() {
    _controller.forward(from: 0);
  }

  /// Stop the current animation
  void stop() {
    _controller.stop();
  }

  /// Provide animation data for external use
  Animation<double> get animation => _animation;

  /// Dispose of the AnimationController resources
  void dispose() {
    _controller.dispose();
  }

  /// Override the `+` operator to combine Shakeable with any Widget and return a ShakeableWidget.
  /// ShakeableWidget uses the provided animation data to implement the shaking effect.
  ShakeableWidget operator +(Widget other) {
    return ShakeableWidget(
      animation: animation,
      child: other,
    );
  }
}

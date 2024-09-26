import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  final bool shouldAnimate;
  final double size;
  final Color? color;
  const Loader({
    super.key,
    required this.shouldAnimate,
    this.color,
    this.size = 60,
  });

  factory Loader.tiny({
    bool shouldAnimate = true,
    Color? color,
  }) {
    return Loader(
      size: 15,
      shouldAnimate: shouldAnimate,
      color: color,
    );
  }

  factory Loader.small({
    bool shouldAnimate = true,
    Color? color,
  }) {
    return Loader(
      size: 30,
      shouldAnimate: shouldAnimate,
      color: color,
    );
  }

  factory Loader.mid({
    bool shouldAnimate = true,
    Color? color,
  }) {
    return Loader(
      size: 70,
      shouldAnimate: shouldAnimate,
      color: color,
    );
  }

  factory Loader.large({
    bool shouldAnimate = true,
  }) {
    return Loader(
      size: 100,
      shouldAnimate: shouldAnimate,
    );
  }

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    const max = 1.5;
    const min = 0.8;

    scale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: min, end: max).chain(
          CurveTween(curve: Curves.easeOut),
        ),
        weight: 8,
      ),
    ]).animate(controller);

    if (widget.shouldAnimate) {
      controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: Icon(
        Icons.fitness_center_rounded,
        size: widget.size,
        color: widget.color ?? Colors.white,
      ),
    );
  }
}

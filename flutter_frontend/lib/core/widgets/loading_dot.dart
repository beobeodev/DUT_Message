import 'package:flutter/material.dart';
import 'package:async/async.dart';

class LoadingDot extends StatefulWidget {
  final double size;

  const LoadingDot({Key? key, this.size = 20}) : super(key: key);

  @override
  State<LoadingDot> createState() => _LoadingDotState();
}

class _LoadingDotState extends State<LoadingDot> with TickerProviderStateMixin {
  static const _beginTimes = [100, 400, 500, 600, 700, 800];

  final List<AnimationController> listAnimationController = [];
  final List<Animation<double>> listScaleAnimation = [];
  final List<Animation<double>> listOpacityAnimation = [];
  final List<CancelableOperation<int>> _delayFeature = [];

  @override
  void initState() {
    super.initState();
    const cubic = Cubic(0.2, 0.68, 0.18, 0.08);

    for (int i = 0; i < 6; ++i) {
      listAnimationController.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1500),
        ),
      );

      listScaleAnimation.add(
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.1), weight: 46),
          TweenSequenceItem(tween: Tween(begin: 0.1, end: 1.0), weight: 46),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 8),
        ]).animate(
          CurvedAnimation(parent: listAnimationController[i], curve: cubic),
        ),
      );

      listOpacityAnimation.add(
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7), weight: 46),
          TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0), weight: 46),
          TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 8),
        ]).animate(
          CurvedAnimation(parent: listAnimationController[i], curve: cubic),
        ),
      );

      CancelableOperation.fromFuture(
        Future.delayed(Duration(milliseconds: _beginTimes[i])).then((_) {
          listAnimationController[i].repeat();
          return 0;
        }),
      );
    }
  }

  @override
  void dispose() {
    for (final f in listAnimationController) {
      f.dispose();
    }
    for (final f in _delayFeature) {
      f.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = List<Widget>.filled(6, Container());
    for (int i = 0; i < 6; i++) {
      widgets[i] = FadeTransition(
        opacity: listOpacityAnimation[i],
        child: ScaleTransition(
          scale: listScaleAnimation[i],
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SizedBox(
              width: widget.size,
              height: widget.size,
            ),
          ),
        ),
      );
    }

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widgets[0],
          const SizedBox(width: 2),
          widgets[1],
          const SizedBox(width: 2),
          widgets[2],
          const SizedBox(width: 2),
          widgets[3],
          const SizedBox(width: 2),
          widgets[4],
          const SizedBox(width: 2),
          widgets[5],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'animations/loader_animation.dart';

import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController loaderController;
  late Animation<double> loaderAnimation;

  @override
  void initState() {
    loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    loaderAnimation = Tween(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(
        parent: loaderController,
        curve: Curves.easeIn,
      ),
    );

    loaderController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: loaderAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: loaderController.status == AnimationStatus.forward
                  ? (math.pi * 2) * loaderController.value
                  : -(math.pi * 2) * loaderController.value,
              child: CustomPaint(
                foregroundPainter: LoaderAnimation(
                  radiusRatio: loaderAnimation.value,
                ),
                size: const Size(300, 300),
              ),
            );
          },
        ),
      ),
    );
  }
}

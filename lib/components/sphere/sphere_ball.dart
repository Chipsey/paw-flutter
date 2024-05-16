// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paw/components/sphere/d_curved.dart';
import 'package:paw/components/sphere/shadow_sphere.dart';
import 'package:paw/components/sphere/sphere_density.dart';

class SphereBall extends StatefulWidget {
  const SphereBall({super.key});

  @override
  State<SphereBall> createState() => _SphereBallState();
}

class _SphereBallState extends State<SphereBall>
    with SingleTickerProviderStateMixin {
  static const lightSource = Offset(0, -0.7);
  Offset _startPoint = Offset.zero;
  Offset _currentPoint = Offset.zero;
  static double globalSize = 0;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _startPoint = details.localPosition;
      _controller.stop(); // Stop any ongoing animation
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      if (_calSquareRoot(_currentPoint.dx, _currentPoint.dy) <=
          globalSize * 0.4) {
        // _currentPoint = Offset.zero;
        _currentPoint = details.localPosition - _startPoint;
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _animation = Tween<Offset>(
      begin: _currentPoint * 0.5,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));

    _controller.reset();
    _controller.forward();

    setState(() {
      _startPoint = Offset.zero;
      _currentPoint = Offset.zero;
    });
  }

  double _calSquareRoot(double x, double y) {
    return sqrt(x * x + y * y);
  }

  @override
  Widget build(BuildContext context) {
    final size = Size.square(MediaQuery.of(context).size.shortestSide - 60);
    globalSize = size.shortestSide;

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Center(
        child: Stack(
          children: [
            ShadowSphere(diameter: size.shortestSide),
            SphereDensity(
              lightSource: lightSource,
              diameter: size.shortestSide,
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: _animation.value,
                    child: Transform(
                      origin: size
                          .center(Offset(_currentPoint.dx, _currentPoint.dy)),
                      transform: Matrix4.identity()..scale(0.5),
                      child: DCurved(
                        lightSource: lightSource,
                        size: size.shortestSide,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

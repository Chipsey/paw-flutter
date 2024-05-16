// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paw/components/sphere/d_curved.dart';
import 'package:paw/components/sphere/shadow_sphere.dart';
import 'package:paw/components/sphere/sphere_density.dart';
import 'package:image_picker/image_picker.dart';

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

  String _currentAction = '';

  File? _selectedImage;

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
          globalSize * 0.35) {
        // _currentPoint = Offset.zero;
        _currentPoint = details.localPosition - _startPoint;
        print(_currentPoint);
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

    Offset _memory = _currentPoint;

    setState(() {
      _startPoint = Offset.zero;
      _currentPoint = Offset.zero;
    });

    if (_memory.dy <= -100) {
      print("Start Camera");
      setState(() {
        _currentAction = "Loading Camera..";
      });
      _pickImageFromCamera();
    }
    if (_memory.dy >= 100) {
      print("Start Gallery");
      setState(() {
        _currentAction = "Loading Gallery..";
      });
      _pickImageFromGallery();
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _currentAction = "";
    });

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);

      setState(() {
        _selectedImage = imageFile;
      });

      // imageProvider.changeImageFile(imageFile);
    }
  }

  Future _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _currentAction = "";
    });

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
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
        child: Column(
          children: [
            Stack(
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
                          origin: size.center(
                              Offset(_currentPoint.dx, _currentPoint.dy)),
                          transform: Matrix4.identity()
                            ..scale(0.5)
                            ..rotateX(-_currentPoint.dy / size.shortestSide)
                            ..rotateY(_currentPoint.dx / size.shortestSide),
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
            SizedBox(
              height: 20,
            ),
            if (_currentAction != '') ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text(_currentAction),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

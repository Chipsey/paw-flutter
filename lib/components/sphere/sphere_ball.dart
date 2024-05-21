// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:paw/components/sphere/d_curved.dart';
// import 'package:paw/components/sphere/shadow_sphere.dart';
import 'package:paw/components/sphere/sphere_density.dart';
import 'package:image_picker/image_picker.dart';

class SphereBall extends StatefulWidget {
  const SphereBall({super.key});

  @override
  State<SphereBall> createState() => _SphereBallState();
}

class _SphereBallState extends State<SphereBall>
    with SingleTickerProviderStateMixin {
  static const lightSource = Offset(0, -0.5);
  Offset _startPoint = Offset.zero;
  Offset _currentPoint = Offset.zero;
  static double globalSize = 0;
  bool _isAnimationOn = false;

  String _currentAction = '';

  File? _selectedImage;

  late AnimationController _controller;
  late Animation<Offset> _animation;

  List<String> petNames = ['Tommy', 'Bella', 'Charlie', 'Max', 'Luna'];
  int currentPetIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
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
          globalSize * 0.5) {
        // _currentPoint = Offset.zero;
        _currentPoint = details.localPosition - _startPoint;
        print(_currentPoint);
      }
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isAnimationOn = true;
    });
    _animation = Tween<Offset>(
      begin: _currentPoint * 0.3,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    ));

    _controller.reset();
    _controller.forward();

    Offset memory = _currentPoint;

    setState(() {
      _startPoint = Offset.zero;
      _currentPoint = Offset.zero;
      _isAnimationOn = false;
    });

    if (memory.dy <= -180) {
      print("Start Camera");
      setState(() {
        _currentAction = "Loading Camera..";
      });
      _pickImageFromCamera();
    }
    if (memory.dy >= 180) {
      print("Start Gallery");
      setState(() {
        _currentAction = "Loading Gallery..";
      });
      _pickImageFromGallery();
    }
    if (memory.dx >= 180) {
      print("Start Gallery");
      setState(() {
        // _currentAction = "Loading Right..";
        currentPetIndex = (currentPetIndex + 1) % petNames.length;
      });
      // _pickImageFromGallery();
    }
    if (memory.dx <= -180) {
      print("Start Gallery");
      setState(() {
        // _currentAction = "Loading Left..";
        currentPetIndex =
            (currentPetIndex - 1 + petNames.length) % petNames.length;
      });
      // _pickImageFromGallery();
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

  //////////////// Color Data ///////////////////
  static final Color baseColor = Color.fromARGB(255, 237, 249, 42);
  static final Color accentColor = Color.fromARGB(255, 137, 141, 8);
  static final Color primaryColor = Color.fromARGB(180, 36, 41, 43);
  ///////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final size = Size.square(MediaQuery.of(context).size.shortestSide - 60);
    globalSize = size.shortestSide;
    final rotationX = -_currentPoint.dy / size.shortestSide * pi;
    final rotationY = _currentPoint.dx / size.shortestSide * pi;

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                // ShadowSphere(diameter: size.shortestSide),
                SphereDensity(
                  lightSource: lightSource,
                  diameter: size.shortestSide,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: -_animation.value * 0.4,
                        child: Transform(
                          origin: size.bottomRight(-_currentPoint * 0.1),
                          transform: Matrix4.identity()..scale(0.025),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(127, 154, 122, 39),
                            ),
                            width: size.shortestSide,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SphereDensity(
                  lightSource: lightSource,
                  diameter: size.shortestSide,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: -_animation.value * 0.4,
                        child: Transform(
                          origin: size.centerLeft(-_currentPoint * 0.1),
                          transform: Matrix4.identity()..scale(0.02),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(90, 225, 225, 225),
                            ),
                            width: size.shortestSide,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SphereDensity(
                  lightSource: lightSource,
                  diameter: size.shortestSide,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: -_animation.value * 0.4,
                        child: Transform(
                          origin: size.topCenter(-_currentPoint * 0.1),
                          transform: Matrix4.identity()..scale(0.03),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(90, 51, 161, 66),
                            ),
                            width: size.shortestSide,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SphereDensity(
                  lightSource: lightSource,
                  diameter: size.shortestSide,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      final offset = _animation.value;
                      final rotationX = -offset.dy / size.shortestSide * pi;
                      final rotationY = offset.dx / size.shortestSide * pi;
                      return Transform.translate(
                        offset: Offset.zero,
                        child: Transform(
                          origin: size.center(Offset.zero),
                          transform: Matrix4.identity()..scale(0.8),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(10, 20),
                                    blurRadius: 20,
                                    color: Color.fromARGB(255, 57, 57, 57)
                                        .withOpacity(0.2))
                              ],
                              gradient: RadialGradient(
                                center:
                                    Alignment(lightSource.dx, lightSource.dy),
                                colors: [baseColor, accentColor],
                              ),
                            ),
                            child: Transform.translate(
                              offset: _animation.value * 0.01,
                              child: Transform(
                                origin: size.center(Offset(
                                  _currentPoint.dx * 0.7,
                                  _currentPoint.dy * 0.7,
                                )),
                                transform: Matrix4.identity()
                                  ..translate(offset.dx, offset.dy)
                                  ..scale(0.6)
                                  ..rotateX(rotationX * 0.7)
                                  ..rotateY(rotationY * 0.7),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/paw.svg',
                                      width: size.shortestSide / 1.3,
                                      color: primaryColor,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      petNames[currentPetIndex],
                                      style: TextStyle(
                                        fontSize: size.shortestSide / 9,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

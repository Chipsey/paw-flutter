// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paw/components/sphere/sphere_density.dart';

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
          globalSize * 0.5) {
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
      begin: _currentPoint * 0.35,
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
        currentPetIndex = (currentPetIndex + 1) % petNames.length;
      });
    }
    if (memory.dx <= -180) {
      print("Start Gallery");
      setState(() {
        currentPetIndex =
            (currentPetIndex - 1 + petNames.length) % petNames.length;
      });
    }
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _currentAction = "";
      _resetScrollController();
    });

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);

      setState(() {
        _selectedImage = imageFile;
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _currentAction = "";
      _resetScrollController();
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

  FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 1);

  void _resetScrollController() {
    setState(() {
      _scrollController.animateToItem(
        1,
        duration: Duration(milliseconds: 2000),
        curve: Curves.bounceOut,
      );
    });
  }

  //////////////// Color Data ///////////////////
  static final Color baseColor = Color.fromARGB(255, 237, 249, 42);
  static final Color accentColor = Color.fromARGB(255, 137, 141, 8);
  static final Color primaryColor = Color.fromARGB(180, 36, 41, 43);
  ///////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final size = Size.square(MediaQuery.of(context).size.shortestSide - 60);
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Center(
        child: Column(
          children: [
            Stack(
              children: [
                SphereDensity(
                  lightSource: lightSource,
                  diameter: size.shortestSide,
                  child: Transform(
                    origin: size.center(Offset.zero),
                    transform: Matrix4.identity()..scale(0.8),
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(10, 20),
                              blurRadius: 20,
                              color: Color.fromARGB(255, 57, 57, 57)
                                  .withOpacity(0.2),
                            )
                          ],
                          gradient: RadialGradient(
                            center: Alignment(lightSource.dx, lightSource.dy),
                            colors: [baseColor, accentColor],
                          ),
                        ),
                        child: PageView.builder(
                          itemCount: petNames.length,
                          controller: PageController(
                            viewportFraction: 2,
                          ),
                          itemBuilder: (context, index) {
                            return Container(
                              width: size.shortestSide,
                              height: size.shortestSide,
                              child: ListWheelScrollView(
                                controller: _scrollController,
                                itemExtent: size.shortestSide + 100,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: (value) {
                                  switch (value) {
                                    case 0:
                                      {
                                        _pickImageFromCamera();
                                        break;
                                      }
                                    case 2:
                                      {
                                        _pickImageFromGallery();
                                        break;
                                      }
                                  }
                                },
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.camera,
                                        size: 100,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Camera",
                                        style: TextStyle(
                                          fontSize: size.shortestSide / 9,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/paw.svg',
                                        width: size.shortestSide / 3,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        petNames[index],
                                        style: TextStyle(
                                          fontSize: size.shortestSide / 9,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 100,
                                        color: primaryColor,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Gallery",
                                        style: TextStyle(
                                          fontSize: size.shortestSide / 9,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

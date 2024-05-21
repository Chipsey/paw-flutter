// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:paw/components/sphere/sphere_density.dart';
import 'package:paw/objects/pet.object.dart';

class SphereBall extends StatefulWidget {
  const SphereBall({super.key});

  @override
  State<SphereBall> createState() => _SphereBallState();
}

class _SphereBallState extends State<SphereBall>
    with SingleTickerProviderStateMixin {
  /////////////// Variables ///////////////////
  static const lightSource = Offset(-0.3, -0.7);
  File? _selectedImage;

  final List<Pet> pets = [
    Pet(name: 'Whiskers', imageUrl: 'assets/images/whiskers.png'),
    Pet(name: 'Buddy', imageUrl: 'assets/images/buddy.png'),
    Pet(name: 'Charlie', imageUrl: 'assets/images/charlie.png'),
    Pet(name: 'Max', imageUrl: 'assets/images/max.png'),
  ];

  // List<String> petNames = ['Tommy', 'Bella', 'Charlie', 'Max', 'Luna'];
  ////////////////////////////////////////////

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.7, end: 0.9).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && _selectedAction != null) {
        _selectedAction!();
        _selectedAction = null;
      }
    });
  }

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);
      setState(() {
        _selectedImage = imageFile;
      });
    }
    _resetScrollController();
  }

  Future<void> _pickImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
    _resetScrollController();
  }

  double _calSquareRoot(double x, double y) {
    return sqrt(x * x + y * y);
  }

  FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: 1);

  void _resetScrollController() {
    _scrollController.animateToItem(
      1,
      duration: Duration(milliseconds: 3500),
      curve: Curves.elasticOut,
    );
  }

  void _changeSphereSize() {
    _animationController.forward();
  }

  void _resetSphereSize() {
    _animationController.reverse();
  }

  void _changeSphereSizeOnPage(int index) {
    // if (index % 2 == 1) {
    //   _animationController.forward();
    // } else {
    //   _animationController.reverse();
    // }
  }

  VoidCallback? _selectedAction;

  void _onSelectedItemChanged(int value) {
    switch (value) {
      case 0:
        _selectedAction = _pickImageFromCamera;
        _changeSphereSize();
        break;
      case 1:
        _resetSphereSize();
        break;
      case 2:
        _selectedAction = _pickImageFromGallery;
        _changeSphereSize();
        break;
    }
  }

  //////////////// Color Data ///////////////////
  static final Color baseColor = Color.fromARGB(255, 188, 137, 185);
  static final Color accentColor = Color.fromARGB(255, 170, 85, 164);
  static final Color primaryColor = Color.fromARGB(200, 255, 255, 255);
  ///////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final size = Size.square(MediaQuery.of(context).size.shortestSide - 60);
    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: child,
                  );
                },
                child: SphereDensity(
                  lightSource: lightSource,
                  diameter: size.shortestSide,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(30, 30),
                          blurRadius: 50,
                          color: Color.fromARGB(255, 125, 67, 121)
                              .withOpacity(0.3),
                        )
                      ],
                    ),
                    child: ClipOval(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            center: Alignment(lightSource.dx, lightSource.dy),
                            colors: [baseColor, accentColor],
                          ),
                        ),
                        child: PageView.builder(
                          itemCount: pets.length,
                          controller: PageController(
                            viewportFraction: 2,
                          ),
                          itemBuilder: (context, index) {
                            _changeSphereSizeOnPage(index);
                            return Container(
                              width: size.shortestSide,
                              height: size.shortestSide,
                              child: ListWheelScrollView(
                                controller: _scrollController,
                                itemExtent: size.shortestSide + 100,
                                physics: FixedExtentScrollPhysics(),
                                onSelectedItemChanged: _onSelectedItemChanged,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        LineAwesomeIcons.camera_solid,
                                        size: 200,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        "Camera",
                                        style: TextStyle(
                                          fontSize: size.shortestSide / 10,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Icon(
                                      //   LineAwesomeIcons.paw_solid,
                                      //   size: 200,
                                      //   color: primaryColor,
                                      // ),
                                      Image.asset(
                                        pets[index].imageUrl,
                                        width: size.shortestSide * 0.6,
                                      ),
                                      Text(
                                        pets[index].name,
                                        style: TextStyle(
                                          fontSize: size.shortestSide / 12,
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
                                        LineAwesomeIcons.image_solid,
                                        size: 200,
                                        color: primaryColor,
                                      ),
                                      Text(
                                        "Gallery",
                                        style: TextStyle(
                                          fontSize: size.shortestSide / 10,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

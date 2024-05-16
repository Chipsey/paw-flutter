// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:paw/components/custom-appbar.dart';
import 'package:paw/components/custom-bottom-navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //////////////// Color Data ///////////////////
  final baseColor = Color.fromARGB(255, 149, 149, 149);
  final accentColor = Color.fromARGB(255, 114, 114, 114);
  ///////////////////////////////////////////////

  final petName = "Jerry";
  bool openCamera = false;

  @override
  Widget build(BuildContext context) {
    double fullDisplayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: baseColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Use stretch to fill horizontal space
        children: [
          ////////////////// App Bar /////////////////////
          CustomAppBar(),
          Stack(
            children: [
              Column(
                children: [
                  ///////////////////// Body /////////////////////
                  pawCircle(petName, fullDisplayWidth),
                  // pawCircle(petName, fullDisplayWidth),
                ],
              ),
            ],
          ),
          // Bottom Nav Bar
          CustomBottomNavBar(),
        ],
      ),
    );
  }

  Widget pawCircle(String petName, double fullDisplayWidth) {
    return Column(
      children: [
        Center(
          child: Draggable<bool>(
            childWhenDragging: Container(),
            feedback: Neumorphic(
              style: NeumorphicStyle(
                surfaceIntensity: 10,
                shape: NeumorphicShape.concave,
                depth: 10,
                lightSource: LightSource.bottomRight,
                color: Colors.grey[100],
                boxShape: NeumorphicBoxShape.circle(),
                border: NeumorphicBorder(
                  color: accentColor,
                  width: 10,
                ),
              ),
              padding: EdgeInsets.all(fullDisplayWidth / 8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(fullDisplayWidth / 15),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/paw.svg',
                              width: fullDisplayWidth / 3,
                              color: Color.fromARGB(0, 255, 255, 255),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              petName,
                              style: TextStyle(
                                fontSize: fullDisplayWidth / 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(0, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: fullDisplayWidth / 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: fullDisplayWidth / 10,
                        height: 7,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(0, 255, 255, 255),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: fullDisplayWidth / 30,
                    child: Icon(Icons.electric_bolt,
                        color: baseColor, size: fullDisplayWidth / 15),
                  ),
                  Positioned(
                    bottom: fullDisplayWidth / 30,
                    child: Icon(Icons.camera,
                        color: baseColor, size: fullDisplayWidth / 15),
                  ),
                  Positioned(
                    left: 0,
                    child: Icon(Icons.phone_in_talk,
                        color: baseColor, size: fullDisplayWidth / 15),
                  ),
                  Positioned(
                    right: 0,
                    child: Icon(Icons.emergency_share,
                        color: baseColor, size: fullDisplayWidth / 15),
                  ),
                ],
              ),
            ),
            child: Neumorphic(
              style: NeumorphicStyle(
                surfaceIntensity: 10,
                shape: NeumorphicShape.concave,
                depth: 10,
                lightSource: LightSource.topLeft,
                color: Colors.grey[100],
                boxShape: NeumorphicBoxShape.circle(),
                border: NeumorphicBorder(
                  color: accentColor,
                  width: 10,
                ),
              ),
              padding: EdgeInsets.all(fullDisplayWidth / 8),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(fullDisplayWidth / 15),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/paw.svg',
                          width: fullDisplayWidth / 3,
                          color: baseColor,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          petName,
                          style: TextStyle(
                            fontSize: fullDisplayWidth / 16,
                            fontWeight: FontWeight.bold,
                            color: baseColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: fullDisplayWidth / 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: fullDisplayWidth / 10,
                    height: 7,
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // DragTarget<int>(
        //   builder: (
        //     BuildContext context,
        //     List<dynamic> accepted,
        //     List<dynamic> rejected,
        //   ) {
        //     return Container(
        //       height: 100.0,
        //       width: 100.0,
        //       color: Colors.cyan,
        //       child: Center(
        //         child: Text('Value'),
        //       ),
        //     );
        //   },
        //   onAcceptWithDetails: (DragTargetDetails<int> details) {
        //     setState(() {
        //       openCamera = true;
        //       print("camera: " + openCamera.toString());
        //     });
        //   },
        // ),
      ],
    );
  }
}

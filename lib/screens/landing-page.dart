// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:paw/components/custom-appbar.dart';
import 'package:paw/components/custom-bottom-navbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paw/components/sphere/sphere_ball.dart';

class LandingPage extends StatefulWidget {
  final double fullDisplayWidth;

  const LandingPage({
    super.key,
    required this.fullDisplayWidth,
  });

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
  double lightHorizontal = 0;
  double lightVertical = 0.4;

  @override
  Widget build(BuildContext context) {
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
                  SphereBall(),
                  // pawCircle(petName, widget.fullDisplayWidth),
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

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      // Normalize the light source values to be between -1 and 1
      lightHorizontal =
          (details.localPosition.dx / widget.fullDisplayWidth) * 3 - 1;
      lightVertical =
          (details.localPosition.dy / widget.fullDisplayWidth) * 3 - 1;

      // Clamp the values to ensure they stay within the valid range
      lightHorizontal = lightHorizontal.clamp(-1.0, 1.0) * -1;
      lightVertical = lightVertical.clamp(-1.0, 1.0) * -1;
    });
  }

  Widget pawCircle(String petName, double fullDisplayWidth) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onPanUpdate: _onPanUpdate,
            child: Neumorphic(
              style: NeumorphicStyle(
                oppositeShadowLightSource: true,
                surfaceIntensity: 0.3,
                shape: NeumorphicShape.concave,
                depth: 50,
                lightSource: LightSource(lightHorizontal, lightVertical),
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
      ],
    );
  }
}

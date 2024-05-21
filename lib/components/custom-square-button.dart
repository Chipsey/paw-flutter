// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class CustomSquareButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String buttonText;
  const CustomSquareButton(
      {super.key,
      required this.buttonText,
      required this.iconColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          NeumorphicButton(
            curve: Curves.bounceOut,
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              depth: 5,
              color: Color.fromARGB(255, 237, 244, 251),
              lightSource: LightSource.topLeft,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              shadowLightColor: Colors.white,
            ),
            onPressed: () {},
            child: Column(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: iconColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            buttonText,
            style: TextStyle(
              color: Color.fromARGB(255, 58, 76, 107),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

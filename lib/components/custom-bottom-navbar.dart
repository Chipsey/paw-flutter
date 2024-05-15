// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const accentColor = Color.fromARGB(255, 114, 114, 114);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  NeumorphicButton(
                    curve: Curves.bounceIn,
                    style: NeumorphicStyle(
                      depth: 3,
                      color: Colors.white,
                      lightSource: LightSource.topLeft,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    onPressed: () {},
                    child: Icon(
                      Icons.volume_up,
                      color: accentColor,
                      size: 30,
                    ),
                  ),
                  NeumorphicButton(
                    curve: Curves.bounceIn,
                    style: NeumorphicStyle(
                      depth: 3,
                      color: Colors.white,
                      lightSource: LightSource.topLeft,
                      boxShape: NeumorphicBoxShape.circle(),
                    ),
                    onPressed: () {},
                    child: Icon(
                      Icons.mic,
                      color: accentColor,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

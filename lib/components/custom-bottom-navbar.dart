// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
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
                      color: NeumorphicTheme.accentColor(context),
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
                      color: NeumorphicTheme.accentColor(context),
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const accentColor = Color.fromARGB(255, 114, 114, 114);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
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
                      child: SvgPicture.asset(
                        'assets/icons/paws.svg',
                        width: 30,
                        color: accentColor,
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
                      child: Image.asset(
                        'assets/icons/heart-rate.png',
                        width: 30,
                        color: accentColor,
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
                      child: SvgPicture.asset(
                        'assets/icons/doctor.svg',
                        width: 30,
                        color: accentColor,
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
                        Icons.location_on,
                        color: accentColor,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/battery.svg',
                      width: 40,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:paw/components/custom-square-button.dart';

class CustomBottomNavBar extends StatelessWidget {
  final Color accentColor;
  const CustomBottomNavBar({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    // const accentColor = Color.fromARGB(255, 114, 114, 114);
    const buttonColor = Colors.blueGrey;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  // NeumorphicButton(
                  //   curve: Curves.bounceIn,
                  //   style: NeumorphicStyle(
                  //     depth: 3,
                  //     color: Colors.white,
                  //     lightSource: LightSource.topLeft,
                  //     boxShape: NeumorphicBoxShape.circle(),
                  //   ),
                  //   onPressed: () {},
                  //   child: Icon(
                  //     Icons.volume_up,
                  //     color: accentColor,
                  //     size: 30,
                  //   ),
                  // ),
                  // NeumorphicButton(
                  //   curve: Curves.bounceIn,
                  //   style: NeumorphicStyle(
                  //     depth: 3,
                  //     color: Colors.white,
                  //     lightSource: LightSource.topLeft,
                  //     boxShape: NeumorphicBoxShape.circle(),
                  //   ),
                  //   onPressed: () {},
                  //   child: Icon(
                  //     Icons.mic,
                  //     color: accentColor,
                  //     size: 30,
                  //   ),
                  // ),
                  CustomSquareButton(
                    buttonText: "Sound",
                    iconColor: buttonColor,
                    icon: LineAwesomeIcons.volume_up_solid,
                  ),
                  CustomSquareButton(
                    buttonText: "Mic",
                    iconColor: buttonColor,
                    icon: LineAwesomeIcons.microphone_solid,
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

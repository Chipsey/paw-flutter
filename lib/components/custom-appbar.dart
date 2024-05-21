// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:paw/components/custom-rounded-button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final Color accentColor;
  const CustomAppBar({super.key, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    // const accentColor = Color.fromARGB(255, 114, 114, 114);
    const buttonColor = Colors.blueGrey;

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
                    CustomRoundedButton(
                      icon: LineAwesomeIcons.paw_solid,
                      iconColor: buttonColor,
                      buttonText: 'Pets',
                    ),
                    CustomRoundedButton(
                      icon: LineAwesomeIcons.heartbeat_solid,
                      iconColor: buttonColor,
                      buttonText: 'Health',
                    ),
                    CustomRoundedButton(
                      icon: LineAwesomeIcons.user_nurse_solid,
                      iconColor: buttonColor,
                      buttonText: 'Med',
                    ),
                    CustomRoundedButton(
                      icon: LineAwesomeIcons.map_marker_solid,
                      iconColor: buttonColor,
                      buttonText: 'Location',
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      LineAwesomeIcons.battery_half_solid,
                      color: Colors.blueGrey,
                      size: 40,
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

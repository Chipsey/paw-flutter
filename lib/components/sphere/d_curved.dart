// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DCurved extends StatelessWidget {
  final petName = "Tommy";
  final Offset lightSource;
  final double size;
  const DCurved({super.key, required this.lightSource, required this.size});
  //////////////// Color Data ///////////////////
  static final baseColor = Color.fromARGB(50, 149, 149, 149);
  static final accentColor = Color.fromARGB(255, 114, 114, 114);
  static final primaryColor = Color.fromARGB(170, 240, 240, 240);
  ///////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final innerShadowWidth = lightSource.distance * 0.1;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // boxShadow: [
        //   BoxShadow(
        //       blurRadius: 25,
        //       color: Color.fromARGB(255, 142, 142, 142).withOpacity(0.6))
        // ],
        gradient: RadialGradient(
          // center: Alignment(lightSource.dx, lightSource.dy),
          stops: [1 - innerShadowWidth, 1],
          colors: [baseColor, accentColor],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/paw.svg',
            width: size / 1.7,
            color: primaryColor,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            petName,
            style: TextStyle(
              fontSize: size / 13,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

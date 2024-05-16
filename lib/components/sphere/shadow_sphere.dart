// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters

import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShadowSphere extends StatefulWidget {
  final double diameter;
  const ShadowSphere({Key? key, required this.diameter}) : super(key: key);
  @override
  State<ShadowSphere> createState() => _ShadowSphereState();
}

class _ShadowSphereState extends State<ShadowSphere> {
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateX(math.pi / 2.1),
      origin: Offset(0, widget.diameter),
      child: Container(
        width: widget.diameter,
        height: widget.diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                blurRadius: 25,
                color: Color.fromARGB(255, 142, 142, 142).withOpacity(0.6))
          ],
        ),
      ),
    );
  }
}

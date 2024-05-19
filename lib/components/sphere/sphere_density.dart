// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_super_parameters, unnecessary_this

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SphereDensity extends StatefulWidget {
  final double diameter;
  final Offset lightSource;
  final Widget child;
  const SphereDensity({
    Key? key,
    required this.diameter,
    required this.lightSource,
    required this.child,
  }) : super(key: key);

  @override
  State<SphereDensity> createState() => _SphereDensityState();
}

class _SphereDensityState extends State<SphereDensity> {
  //////////////// Color Data ///////////////////
  final accentColor = Color.fromARGB(0, 140, 140, 140);
  final baseColor = Color.fromARGB(0, 114, 114, 114);
  ///////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.diameter,
      height: widget.diameter,
      decoration: BoxDecoration(
        color: accentColor,
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center:
              Alignment(this.widget.lightSource.dx, this.widget.lightSource.dy),
          colors: [baseColor, accentColor],
        ),
      ),
      child: widget.child,
    );
  }
}

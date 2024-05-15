// ignore_for_file: prefer_const_constructors

import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:paw/screens/landing-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: NeumorphicThemeData(
        baseColor: Color.fromARGB(255, 149, 149, 149),
        lightSource: LightSource.topLeft,
        accentColor: Color.fromARGB(255, 114, 114, 114),
        depth: 3,
      ),
      home: LandingPage(),
    );
  }
}

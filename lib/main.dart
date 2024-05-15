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
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color.fromARGB(255, 232, 232, 232),
        lightSource: LightSource.topLeft,
        depth: 3,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 3,
      ),
      home: LandingPage(),
    );
  }
}

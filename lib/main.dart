import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:notesapp/core/provider%20injection/provider_injection.dart';
import 'package:notesapp/core/theme/themedata.dart';
import 'package:notesapp/orientation_detection.dart';
import 'package:notesapp/presentation/screen/on_boarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initProvider();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          OrientationBuilder(builder: (context, orientation) {
        OrientationDetection.init(constraints, orientation);
        return GetMaterialApp(
          title: 'Notes Data',
          theme: MyThemeData.notesThemeData,
          home: OnBoardingScreen(),
        );
      }),
    );
  }
}

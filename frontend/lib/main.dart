import 'dart:ui';
import 'package:charles_warburton/DashBoard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: ThemeData(scaffoldBackgroundColor: AppColors.backGroundDark),
      scrollBehavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
      title: 'Game Pop',
      debugShowCheckedModeBanner: false,
      home: const DashBoard(),
    );
  }
}
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}


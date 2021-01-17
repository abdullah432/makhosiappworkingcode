import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/general_ui/splash_screen.dart';
import 'package:makhosi_app/utils/app_colors.dart';
//import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //SharedPreferences.setMockInitialValues({});
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColors.COLOR_PRIMARY,
        accentColor: AppColors.COLOR_PRIMARY,
        cursorColor: AppColors.COLOR_GREY,
        colorScheme: ColorScheme.light(primary: AppColors.COLOR_PRIMARY),
      ),
      home: SplashScreen(),
    ),
  );
}

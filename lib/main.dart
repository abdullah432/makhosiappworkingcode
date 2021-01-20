import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:makhosi_app/main_ui/general_ui/splash_screen.dart';
import 'package:makhosi_app/utils/app_colors.dart';
import 'package:provider/provider.dart';
import './utils/file_picker_service.dart';
import './utils/firebasestorageservice.dart';
import 'utils/firestore_service.dart';
//import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('main1');
  //SharedPreferences.setMockInitialValues({});
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<FirestoreService>(
        create: (_) => FirestoreService(),
      ),
      ChangeNotifierProvider<FilePickerService>(
          create: (_) => FilePickerService()),
      ChangeNotifierProvider(create: (_) => FirebaseStorageService()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColors.COLOR_PRIMARY,
        accentColor: AppColors.COLOR_PRIMARY,
        // cursorColor: AppColors.COLOR_GREY,
        colorScheme: ColorScheme.light(primary: AppColors.COLOR_PRIMARY),
      ),
      home: SplashScreen(),
    ),
  ));
}

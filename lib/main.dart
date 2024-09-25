import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasbih/constants/colors.dart';
import 'package:tasbih/pages/tasbih_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable edge-to-edge mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness:
        Brightness.light, // Adjust based on light/dark theme
    statusBarIconBrightness: Brightness.light, // Adjust for status bar icons
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: MyColors.primaryMaterialColor,
        textTheme: GoogleFonts.cairoTextTheme(),
      ),
      title: "tasbih",
      home: const TasbihPage(),
    );
  }
}

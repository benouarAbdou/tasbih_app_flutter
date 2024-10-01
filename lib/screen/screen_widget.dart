import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasbih/constants/colors.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
              color: MyColors.primaryColor,
              child: Center(
                child: Text(
                  '1025!',
                  style: GoogleFonts.cairo(
                    color: Colors.white,
                  ),
                ),
              ))),
    );
  }
}

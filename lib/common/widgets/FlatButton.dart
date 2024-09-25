import 'package:flutter/material.dart';
import 'package:tasbih/constants/colors.dart';

class FlatButton extends StatelessWidget {
  final String text;
  final Function onTap;
  const FlatButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          elevation: 0,
          backgroundColor: MyColors.primaryColor,
        ),
        onPressed: () =>
            onTap(), // Fixed: Use a lambda to pass the function reference.
        child: Text(text),
      ),
    );
  }
}

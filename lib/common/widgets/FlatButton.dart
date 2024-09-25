import 'package:flutter/material.dart';
import 'package:tasbih/constants/colors.dart';
import 'package:tasbih/controllers/tasbih_controller.dart';

class FlatButton extends StatelessWidget {
  final String text;
  final TextEditingController goalController;
  final TasbihController controller;
  const FlatButton(
      {super.key,
      required this.text,
      required this.goalController,
      required this.controller});

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
        onPressed: () {
          int newGoalValue = int.tryParse(goalController.text) ?? 0;
          controller.updateGoalValue(newGoalValue);
          Navigator.of(context).pop(); // Close the modal
        },
        child: Text(text),
      ),
    );
  }
}

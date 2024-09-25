import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasbih/common/widgets/FlatButton.dart';
import 'package:tasbih/controllers/tasbih_controller.dart';

class ModalsAllerts {
  static showGoalUpdateModal(
      BuildContext context, TasbihController controller) {
    TextEditingController goalController = TextEditingController(
      text: controller.goalValue.value.toString(),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom +
                kBottomNavigationBarHeight,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                "تغيير الهدف",
                style: GoogleFonts.cairo(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              // Number text field for goal
              TextField(
                controller: goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              // Button to update the goal value
              FlatButton(
                  text: "تحديث",
                  goalController: goalController,
                  controller: controller)
            ],
          ),
        );
      },
    );
  }
}

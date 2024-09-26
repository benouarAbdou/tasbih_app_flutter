import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasbih/common/widgets/FlatButton.dart';
import 'package:tasbih/controllers/tasbih_controller.dart';

class ModalsAllerts {
  static showGoalUpdateModal(BuildContext context) {
    final TasbihController controller = TasbihController.instance;
    TextEditingController textController = TextEditingController(
      text: controller.currentDikr.value.goalValue.toString(),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
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
                  controller: textController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Button to update the goal value
                FlatButton(
                  text: "تحديث",
                  onTap: () {
                    int newGoalValue = int.tryParse(textController.text) ?? 0;
                    controller.updateGoalValue(newGoalValue);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static showAddDikrModal(BuildContext context) {
    final TasbihController controller = TasbihController.instance;
    TextEditingController textController = TextEditingController();
    TextEditingController goalController = TextEditingController();
    String errorText = "";

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
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
                    Text(
                      "اضافة ذكر",
                      style: GoogleFonts.cairo(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: textController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: "الذكر",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: goalController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "الهدف",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    errorText.isNotEmpty
                        ? Text(
                            errorText,
                            style: const TextStyle(color: Colors.red),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(height: 10),
                    FlatButton(
                      text: "اضافة",
                      onTap: () {
                        final String text = textController.text;
                        final int goalValue =
                            int.tryParse(goalController.text) ?? 0;

                        if (text.isNotEmpty) {
                          controller.addDikr(text, goalValue);
                          Navigator.pop(context);
                        } else {
                          setState(() {
                            errorText = "الرجاء كتابة اسم الذكر ";
                          });
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

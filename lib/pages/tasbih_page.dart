import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasbih/common/functions/modals&allerts.dart';
import 'package:tasbih/common/widgets/CircularButton.dart';
import 'package:tasbih/constants/colors.dart';
import 'package:tasbih/controllers/tasbih_controller.dart';

class TasbihPage extends StatelessWidget {
  const TasbihPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // GetX Controller for managing state
    final TasbihController controller = Get.put(TasbihController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyColors.primaryColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.cover,
            ),
          ),
          /*Positioned(
            top: kTextTabBarHeight + 10,
            left: 40,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: MyColors.secondaryColor,
              ),
              child: const Text(
                "تغيير الذكر",
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),*/
          Align(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Display the current dikr using Obx to reactively update the UI
                Obx(() => Text(
                      controller.dikr.value,
                      style: GoogleFonts.rakkas(
                        color: MyColors.whiteColor,
                        fontSize: 60,
                      ),
                    )),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularButton(
                      height: 30,
                      width: 30,
                      iconSize: 15,
                      icon: Icons.edit,
                      circleColor: MyColors.secondaryColor,
                      onPressed: () {
                        // Show the modal bottom sheet
                        ModalsAllerts.showGoalUpdateModal(context, controller);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Display the goal value
                    Obx(() => Text(
                          "الهدف : ${controller.goalValue.value}",
                          style: GoogleFonts.cairo(
                            color: MyColors.whiteColor,
                            fontSize: 25,
                          ),
                        )),
                  ],
                ),
                // Display the current todayCount
                Obx(() => Text(
                      "${controller.todayCount.value}",
                      style: GoogleFonts.rakkas(
                        color: MyColors.whiteColor,
                        fontSize: 100,
                      ),
                    )),
                // Circular button to increment the todayCount
                CircularButton(
                  height: 150,
                  width: 150,
                  iconSize: 60,
                  icon: Icons.add,
                  onPressed: () {
                    controller.incrementTodayCount();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

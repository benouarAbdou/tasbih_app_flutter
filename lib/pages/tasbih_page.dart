import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasbih/common/functions/modals&allerts.dart';
import 'package:tasbih/common/widgets/CircularButton.dart';
import 'package:tasbih/constants/colors.dart';
import 'package:tasbih/controllers/tasbih_controller.dart';
import 'package:tasbih/pages/dikr_page.dart';

class TasbihPage extends StatelessWidget {
  const TasbihPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasbihController controller = Get.put(TasbihController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        decoration: const BoxDecoration(
          color: MyColors.primaryColor,
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Get.to(() => const DikrPage()),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
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
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Text(
                          controller.currentDikr.value.text,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.rakkas(
                            height: 1,
                            color: MyColors.whiteColor,
                            fontSize: 60,
                          ),
                        )),
                    const SizedBox(height: 25),
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
                            ModalsAllerts.showGoalUpdateModal(context);
                          },
                        ),
                        const SizedBox(width: 10),
                        Obx(() => Text(
                              "الهدف : ${controller.currentDikr.value.goalValue}",
                              style: GoogleFonts.cairo(
                                color: MyColors.whiteColor,
                                fontSize: 25,
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${controller.currentDikr.value.todayCount} ",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rakkas(
                                  color: MyColors.whiteColor,
                                  fontSize: 120,
                                  height: 1),
                            ),
                            CircularButton(
                                height: 30,
                                width: 30,
                                iconSize: 20,
                                circleColor: Colors.redAccent,
                                icon: Icons.restart_alt,
                                onPressed: () async {
                                  bool? confirmReset = await ModalsAllerts
                                      .showDeleteConfirmation(
                                    context,
                                    'إعادة تعيين',
                                    'هل أنت متأكد أنك تريد محو تقدمك في هذا الذكر؟',
                                    'إعادة تعيين',
                                  );
                                  if (confirmReset == true) {
                                    controller.resetOneTodayCount(
                                        controller.currentDikr.value.id);
                                  }
                                }),
                          ],
                        )),
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
        ),
      ),
    );
  }
}

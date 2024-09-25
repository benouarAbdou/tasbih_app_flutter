import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasbih/constants/colors.dart';
import 'package:tasbih/controllers/tasbih_controller.dart';
import 'package:tasbih/models/dikr_model.dart';
import 'package:tasbih/pages/tasbih_page.dart';

class DikrWidget extends StatelessWidget {
  final Dikr dikr;
  final bool isChoosen;

  const DikrWidget({
    super.key,
    required this.dikr,
    required this.isChoosen,
  });

  @override
  Widget build(BuildContext context) {
    final TasbihController controller = TasbihController.instance;

    return GestureDetector(
      onTap: () {
        controller.currentDikr.value = dikr;
        Get.off(() => const TasbihPage());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // Push items to the right
          children: [
            // Expanded Column to take up available space
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.end, // Align text to the right
                children: [
                  Text(
                    dikr.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${dikr.todayCount} / ${dikr.goalValue}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
                width: 10), // Add space between text and the indicator
            // Indicator on the far right
            Container(
              width: 5,
              height: 40, // Make the height more noticeable
              decoration: BoxDecoration(
                color: isChoosen ? MyColors.primaryColor : Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

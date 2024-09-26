import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasbih/common/functions/modals&allerts.dart';
import 'package:tasbih/common/widgets/DikrWidget.dart';
import 'package:tasbih/constants/colors.dart';
import 'package:tasbih/controllers/tasbih_controller.dart';
import 'package:tasbih/pages/tasbih_page.dart';

class DikrPage extends StatelessWidget {
  const DikrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TasbihController controller = TasbihController.instance;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ModalsAllerts.showAddDikrModal(context);
        },
        elevation: 0,
        child: const Icon(
          Icons.add,
          color: MyColors.whiteColor,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: kTextTabBarHeight + 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Get.off(() => const TasbihPage()),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "التسبيح",
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.arrow_forward_ios, size: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                if (controller.dikrs.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.dikrs.length,
                  itemBuilder: (context, index) {
                    final dikr = controller.dikrs[index];
                    return DikrWidget(
                      dikr: dikr,
                      isChoosen: dikr.id == controller.currentDikr.value.id,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

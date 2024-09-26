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
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: isChoosen
              ? Border.all(color: MyColors.primaryColor, width: 2)
              : null,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjust alignment
          children: [
            // Delete button (Trash icon)
            IconButton(
              icon: const Icon(Icons.delete, color: MyColors.primaryColor),
              onPressed: () async {
                // Check if there is more than one dikr in the list
                if (controller.dikrs.length <= 1) {
                  // Show a warning message in Arabic if there's only one dikr left
                  _showCannotDeleteMessage(context);
                } else {
                  // Confirm deletion
                  bool? confirmDelete = await _showDeleteConfirmation(context);
                  if (confirmDelete == true) {
                    controller.deleteDikr(dikr.id); // Delete the Dikr
                  }
                }
              },
            ),
            const SizedBox(
                width: 10), // Space between the delete button and text

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

  // Show a confirmation dialog before deletion
  Future<bool?> _showDeleteConfirmation(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('حذف الذكر', textAlign: TextAlign.right),
          content: const Text('هل أنت متأكد أنك تريد حذف هذا الذكر؟'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }

  // Show a message if the user tries to delete the last Dikr
  void _showCannotDeleteMessage(BuildContext context) {
    Get.snackbar(
      'تحذير',
      'يجب أن يبقى على الأقل ذكر واحد',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      titleText: const Text(
        'تحذير',
        textAlign: TextAlign.right,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      messageText: const Text(
        'يجب أن يبقى على الأقل ذكر واحد',
        textAlign: TextAlign.right,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

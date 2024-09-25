import 'package:get/get.dart';
import 'package:tasbih/models/dikr_model.dart';
import 'package:tasbih/repositories/tasbih_repo.dart';

class TasbihController extends GetxController {
  static TasbihController get instance => Get.find();
  final TasbihRepository _repository = TasbihRepository();

  var dikrs = <Dikr>[].obs;
  var currentDikr = Dikr.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllDikrs();
  }

  void fetchAllDikrs() async {
    final dikrDataList = await _repository.getAllDikrs();
    dikrs.value = dikrDataList.map((data) => Dikr.fromMap(data)).toList();
    if (dikrs.isNotEmpty) {
      currentDikr.value = dikrs[0];
    }
  }

  // Increment todayCount and update the list as well as the currentDikr
  void incrementTodayCount() async {
    // Create the updated Dikr
    var updatedDikr = Dikr(
      id: currentDikr.value.id,
      text: currentDikr.value.text,
      todayCount: currentDikr.value.todayCount + 1,
      goalValue: currentDikr.value.goalValue,
    );

    // Update the currentDikr
    currentDikr.value = updatedDikr;

    // Find the index of the currentDikr in the list and update it
    int index = dikrs.indexWhere((dikr) => dikr.id == updatedDikr.id);
    if (index != -1) {
      dikrs[index] = updatedDikr; // Update the list
    }

    // Update the value in the repository
    await _repository.updateTodayCount(updatedDikr.id, updatedDikr.todayCount);
  }

  // Update the goalValue and reflect the change in the list as well as currentDikr
  void updateGoalValue(int newGoal) async {
    // Create the updated Dikr
    var updatedDikr = Dikr(
      id: currentDikr.value.id,
      text: currentDikr.value.text,
      todayCount: currentDikr.value.todayCount,
      goalValue: newGoal,
    );

    // Update the currentDikr
    currentDikr.value = updatedDikr;

    // Find the index of the currentDikr in the list and update it
    int index = dikrs.indexWhere((dikr) => dikr.id == updatedDikr.id);
    if (index != -1) {
      dikrs[index] = updatedDikr; // Update the list
    }

    // Update the value in the repository
    await _repository.updateGoalValue(updatedDikr.id, newGoal);
  }
}

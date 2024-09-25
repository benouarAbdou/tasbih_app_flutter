import 'package:get/get.dart';
import 'package:tasbih/repositories/tasbih_repo.dart';

class TasbihController extends GetxController {
  final TasbihRepository _repository = TasbihRepository();

  // State variables
  var dikr = ''.obs;
  var todayCount = 0.obs;
  var goalValue = 0.obs;
  var dikrId = 0.obs; // Store the id of the dikr

  @override
  void onInit() {
    super.onInit();
    fetchFirstDikr();
  }

  // Fetch the first dikr and update state
  void fetchFirstDikr() async {
    final dikrData = await _repository.getFirstDikr();
    if (dikrData != null) {
      dikr.value = dikrData['dikr'];
      todayCount.value = dikrData['todayCount'] ?? 0;
      goalValue.value = dikrData['goalValue'] ?? 0;
      dikrId.value = dikrData['dikrId'];
    }
  }

  // Increment todayCount and save the new value to the database
  void incrementTodayCount() async {
    todayCount.value++;
    await _repository.updateTodayCount(dikrId.value, todayCount.value);
  }

  // Update the goal value
  void updateGoalValue(int newGoal) async {
    goalValue.value = newGoal;
    await _repository.updateGoalValue(dikrId.value, newGoal);
  }
}

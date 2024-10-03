import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';
import 'package:home_widget/home_widget.dart';
import 'package:tasbih/common/functions/preferenceHelper.dart';
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
    checkForNewDay();
  }

  // Check if it's a new day and reset counts if necessary
  void checkForNewDay() async {
    bool isNewDay = await PreferencesHelper.isNewDay();

    if (isNewDay) {
      // Reset all todayCounts to 0 if it's a new day
      resetAllTodayCounts();
      await PreferencesHelper.saveCurrentDate(); // Save the new date
    }

    // Fetch all Dikrs regardless of whether it was a new day or not
    fetchAllDikrs();
  }

  void fetchAllDikrs() async {
    final dikrDataList = await _repository.getAllDikrs();
    dikrs.value = dikrDataList.map((data) => Dikr.fromMap(data)).toList();

    if (dikrs.isNotEmpty) {
      // Get the last selected Dikr ID from SharedPreferences
      int? lastDikrId = await PreferencesHelper.getLastCurrentDikrId();

      if (lastDikrId != null) {
        // Find the saved currentDikr by ID
        currentDikr.value = dikrs.firstWhere(
          (dikr) => dikr.id == lastDikrId,
          orElse: () => dikrs[0],
        );
      } else {
        currentDikr.value = dikrs[0]; // Fallback to the first Dikr
      }
    }
  }

  // Increment todayCount and update the list as well as the currentDikr
  void incrementTodayCount() async {
    var updatedDikr = Dikr(
      id: currentDikr.value.id,
      text: currentDikr.value.text,
      todayCount: currentDikr.value.todayCount + 1,
      goalValue: currentDikr.value.goalValue,
    );

    // Update currentDikr
    currentDikr.value = updatedDikr;

    // Save currentDikr ID
    await PreferencesHelper.saveCurrentDikrId(updatedDikr.id);
    Vibrate.feedback(FeedbackType.light);
    if (currentDikr.value.todayCount % 100 == 0) {
      Vibrate.feedback(FeedbackType.heavy);
    }

    // Update the list and repository
    int index = dikrs.indexWhere((dikr) => dikr.id == updatedDikr.id);
    if (index != -1) {
      dikrs[index] = updatedDikr;
    }
    await _repository.updateTodayCount(updatedDikr.id, updatedDikr.todayCount);

    // Update the widget after increment
    _updateWidget(updatedDikr.text, updatedDikr.todayCount);
  }

// Function to update the widget
  Future<void> _updateWidget(String dikrName, int dikrValue) async {
    try {
      await HomeWidget.saveWidgetData<String>('dikr_name', dikrName);
      await HomeWidget.saveWidgetData<String>(
          'dikr_value', dikrValue.toString());
      await HomeWidget.updateWidget(
        name: 'MyWidgetProvider', // Android Widget Provider Class Name
      );
      print("Widget Updated");
    } catch (e) {
      print('Error updating widget: $e');
    }
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

  void resetAllTodayCounts() async {
    // Reset in the local database
    await _repository.resetAllTodayCounts();

    // Update the list in memory (dikrs)
    dikrs.value = dikrs.map((dikr) {
      return Dikr(
        id: dikr.id,
        text: dikr.text,
        todayCount: 0, // Reset todayCount to 0
        goalValue: dikr.goalValue,
      );
    }).toList();

    // Update the currentDikr if necessary
    if (dikrs.isNotEmpty) {
      currentDikr.value = dikrs[0]; // Optional: adjust logic if needed
    }
  }

  void resetOneTodayCount(int dikrId) async {
    // Reset in the local database
    await _repository.resetTodayCount(dikrId);

    // Update the list in memory (dikrs)
    dikrs.value = dikrs.map((dikr) {
      return dikr.id == dikrId
          ? Dikr(
              id: dikr.id,
              text: dikr.text,
              todayCount: 0, // Reset todayCount to 0
              goalValue: dikr.goalValue,
            )
          : dikr;
    }).toList();

    // Update the currentDikr if necessary
    if (currentDikr.value.id == dikrId) {
      currentDikr.value = dikrs.firstWhere((dikr) => dikr.id == dikrId);
    }
  }

  // Method to add a new Dikr
  void addDikr(String text, int goalValue) async {
    // Insert new Dikr into the database and get the newly inserted ID
    int newDikrId = await _repository.addDikr(text, goalValue);

    // Create a new Dikr object and add it to the in-memory list
    var newDikr = Dikr(
      id: newDikrId,
      text: text,
      todayCount: 0,
      goalValue: goalValue,
    );

    dikrs.add(newDikr);
  }

  // Add this to the TasbihController class
  void deleteDikr(int dikrId) async {
    await _repository.deleteDikr(dikrId);
    dikrs.removeWhere((dikr) => dikr.id == dikrId);

    if (currentDikr.value.id == dikrId) {
      if (dikrs.isNotEmpty) {
        currentDikr.value = dikrs.first;
        // Save the new currentDikr ID
        await PreferencesHelper.saveCurrentDikrId(currentDikr.value.id);
      }
    }
  }
}

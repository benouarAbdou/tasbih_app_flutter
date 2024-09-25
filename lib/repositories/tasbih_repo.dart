import 'package:tasbih/common/functions/myDataBase.dart';

class TasbihRepository {
  final SqlDb _sqlDb = SqlDb();

  // Fetch the first dikr from the table
  Future<Map<String, dynamic>?> getFirstDikr() async {
    List<Map<String, dynamic>> data =
        await _sqlDb.readData('SELECT * FROM dikr LIMIT 1');
    if (data.isNotEmpty) {
      return data.first;
    }
    return null;
  }

  // Update the todayCount in the database
  Future<void> updateTodayCount(int dikrId, int newCount) async {
    await _sqlDb.updateData(
        'UPDATE dikr SET todayCount = $newCount WHERE dikrId = $dikrId');
  }

  // Update the goal value in the database
  Future<void> updateGoalValue(int dikrId, int newGoal) async {
    await _sqlDb.updateData(
        'UPDATE dikr SET goalValue = $newGoal WHERE dikrId = $dikrId');
  }
}

import 'package:tasbih/common/functions/myDataBase.dart';

class TasbihRepository {
  final SqlDb _sqlDb = SqlDb();

  Future<List<Map<String, dynamic>>> getAllDikrs() async {
    return await _sqlDb.readData('SELECT * FROM dikr');
  }

  // Fetch the first dikr from the table
  Future<Map<String, dynamic>?> getFirstDikr() async {
    List<Map<String, dynamic>> data =
        await _sqlDb.readData('SELECT * FROM dikr LIMIT 1');
    if (data.isNotEmpty) {
      return data.first;
    }
    return null;
  }

  Future<void> resetAllTodayCounts() async {
    await _sqlDb.updateData('UPDATE dikr SET todayCount = 0');
  }

  Future<void> resetTodayCount(int dikrId) async {
    await _sqlDb
        .updateData('UPDATE dikr SET todayCount = 0 WHERE dikrId = $dikrId');
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

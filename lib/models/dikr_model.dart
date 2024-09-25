class Dikr {
  final int id;
  final String text;
  final int todayCount;
  final int goalValue;

  Dikr({
    required this.id,
    required this.text,
    required this.todayCount,
    required this.goalValue,
  });

  // Factory method to create a Dikr instance from a Map
  factory Dikr.fromMap(Map<String, dynamic> map) {
    return Dikr(
      id: map['dikrId'],
      text: map['dikr'],
      todayCount: map['todayCount'] ?? 0,
      goalValue: map['goalValue'] ?? 0,
    );
  }

  static Dikr empty() {
    return Dikr(
      id: 0,
      text: '',
      todayCount: 0,
      goalValue: 0,
    );
  }
}

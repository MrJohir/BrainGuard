class RelapseRequestModel {
  final int mood;
  final int urg;
  final String triggers;
  final String note;
  final String startDate;
  final bool isDeleted;

  RelapseRequestModel({
    required this.mood,
    required this.urg,
    required this.triggers,
    required this.note,
    required this.startDate,
    this.isDeleted = false,
  });

  Map<String, dynamic> toJson() {
    return {
      "Mood": mood,
      "urg": urg,
      "Triggers": triggers,
      "note": note,
      "startDate": startDate,
      "isDeleted": isDeleted,
    };
  }
}

class JournalEntry {
  final String id;
  final String note;
  final String date;
  final int mode;
  final int urge;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final String formattedDate;
  final String formattedTime;

  JournalEntry({
    required this.id,
    required this.note,
    required this.date,
    required this.mode,
    required this.urge,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.formattedDate,
    required this.formattedTime,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id']?.toString() ?? '',
      note: json['note']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
      mode: json['mode'] is int ? json['mode'] : (int.tryParse(json['mode']?.toString() ?? '0') ?? 0),
      urge: json['urge'] is int ? json['urge'] : (int.tryParse(json['urge']?.toString() ?? '0') ?? 0),
      userId: json['userId']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      formattedDate: json['formattedDate']?.toString() ?? '',
      formattedTime: json['formattedTime']?.toString() ?? '',
    );
  }
}
class JournalEntryModel {
  final String note;
  final String date;
  final int mode;
  final int urge;

  JournalEntryModel({
    required this.note,
    required this.date,
    required this.mode,
    required this.urge,
  });

  Map<String, dynamic> toJson() => {
        'note': note,
        'date': date,
        'mode': mode,
        'urge': urge,
      };
}
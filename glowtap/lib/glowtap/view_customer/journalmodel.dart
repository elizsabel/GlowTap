class JournalModel {
  int? id;
  String date;
  String note;

  JournalModel({
    this.id,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() => {
        "id": id,
        "date": date,
        "note": note,
      };

  factory JournalModel.fromMap(Map<String, dynamic> map) => JournalModel(
        id: map["id"],
        date: map["date"],
        note: map["note"],
      );
}

class JournalModel {
  int? id;
  String date; // Tanggal catatan
  String note; // Isi catatan

  JournalModel({
    this.id,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'note': note,
    };
  }

  static JournalModel fromMap(Map<String, dynamic> map) {
    return JournalModel(
      id: map['id'],
      date: map['date'],
      note: map['note'],
    );
  }
}

class JournalModel {
  int? id;
  String content; // Isi catatan
  String date; // Tanggal dibuat

  JournalModel({
    this.id,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'date': date,
    };
  }

  static JournalModel fromMap(Map<String, dynamic> map) {
    return JournalModel(
      id: map['id'],
      content: map['content'],
      date: map['date'],
    );
  }
}

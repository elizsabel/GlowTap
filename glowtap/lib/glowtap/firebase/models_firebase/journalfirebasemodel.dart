import 'dart:convert';

class JournalFirebaseModel {
  String? id;      // Firestore document ID (doc.id)
  String uid;      // UID user pemilik journal
  String date;     // Tanggal catatan (string)
  String note;     // Isi catatan

  JournalFirebaseModel({
    this.id,
    required this.uid,
    required this.date,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "date": date,
      "note": note,
    };
  }

  factory JournalFirebaseModel.fromMap(String id, Map<String, dynamic> map) {
    return JournalFirebaseModel(
      id: id,
      uid: map['uid'] ?? "",
      date: map['date'] ?? "",
      note: map['note'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());
}

import 'dart:convert';

class HistoryFirebaseModel {
  String? id;            // Firestore document ID
  String uid;            // UID user pemilik booking
  String treatment;      // Nama treatment
  String doctor;         // Nama dokter
  String doctorPhone;    // Nomor dokter
  String customerPhone;  // HP customer
  String date;           // Tanggal booking
  String time;           // Jam booking
  String price;          // Harga
  String address;        // Alamat customer
  String note;           // Catatan tambahan
  String status;         // pending / confirmed / done / canceled

  HistoryFirebaseModel({
    this.id,
    required this.uid,
    required this.treatment,
    required this.doctor,
    required this.doctorPhone,
    required this.customerPhone,
    required this.date,
    required this.time,
    required this.price,
    required this.address,
    required this.note,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "treatment": treatment,
      "doctor": doctor,
      "doctorPhone": doctorPhone,
      "customerPhone": customerPhone,
      "date": date,
      "time": time,
      "price": price,
      "address": address,
      "note": note,
      "status": status,
    };
  }

  factory HistoryFirebaseModel.fromMap(String id, Map<String, dynamic> map) {
    return HistoryFirebaseModel(
      id: id,
      uid: map["uid"] ?? "",
      treatment: map["treatment"] ?? "",
      doctor: map["doctor"] ?? "",
      doctorPhone: map["doctorPhone"] ?? "",
      customerPhone: map["customerPhone"] ?? "",
      date: map["date"] ?? "",
      time: map["time"] ?? "",
      price: map["price"] ?? "",
      address: map["address"] ?? "",
      note: map["note"] ?? "",
      status: map["status"] ?? "pending",
    );
  }

  String toJson() => json.encode(toMap());
}

import 'dart:convert';

class HistoryFirebaseModel {
  String? id;
  String uid;
  String treatment;
  String doctor;
  String doctorPhone;
  String customerPhone;
  String date; // YYYY-MM-DD agar Firestore bisa order
  String time;
  String price;
  String address;
  String note;
  String status;

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
      status: map["status"] ?? "Dijadwalkan",
    );
  }

  String toJson() => json.encode(toMap());
}

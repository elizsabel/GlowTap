class HistoryModel {
  final int? id;
  final String treatment;
  final String doctor;
  final String doctorPhone;
  final String customerPhone;
  final String date;
  final String time;
  final String price;
  final String address;
  final String note;
  final String status;

  HistoryModel({
    this.id,
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

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'],
      treatment: map['treatment'] ?? '',
      doctor: map['doctor'] ?? '',
      doctorPhone: map['doctorPhone'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      price: map['price'] ?? '',
      address: map['address'] ?? '',
      note: map['note'] ?? '',
      status: map['status'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'treatment': treatment,
      'doctor': doctor,
      'doctorPhone': doctorPhone,
      'customerPhone': customerPhone,
      'date': date,
      'time': time,
      'price': price,
      'address': address,
      'note': note,
      'status': status,
    };
  }
}

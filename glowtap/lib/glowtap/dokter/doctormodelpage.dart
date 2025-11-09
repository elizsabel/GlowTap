import 'dart:convert';

class DoctorModel {
  int? id;
  String name;        // Nama dokter
  String specialty;   // Spesialisasi / bidang
  String licenseNo;   // Nomor STR / izin praktek
  String phone;       // Nomor WhatsApp / Telp
  String password;    // Password login dokter
  String area;        // Area layanan / jangkauan kota
  String price;       // Tarif “Start From”
  String bio;         // Deskripsi singkat
  double rating;      // Default 5.0 (optional)
  String? photoUrl;   // Optional foto profil

  DoctorModel({
    this.id,
    required this.name,
    required this.specialty,
    required this.licenseNo,
    required this.phone,
    required this.password,    // ✅ Ditambahkan
    required this.area,
    required this.price,
    required this.bio,
    this.rating = 5.0,
    this.photoUrl,
  });

  // Convert ke Map untuk simpan ke SQLite
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'specialty': specialty,
        'licenseNo': licenseNo,
        'phone': phone,
        'password': password,  // ✅ WAJIB disimpan
        'area': area,
        'price': price,
        'bio': bio,
        'rating': rating,
        'photoUrl': photoUrl,
      };

  // Convert SQLite Map → Model
  static DoctorModel fromMap(Map<String, dynamic> map) => DoctorModel(
        id: map['id'],
        name: map['name'],
        specialty: map['specialty'],
        licenseNo: map['licenseNo'],
        phone: map['phone'],
        password: map['password'],  // ✅ Ambil password
        area: map['area'],
        price: map['price'],
        bio: map['bio'],
        rating: map['rating'] is int
            ? (map['rating'] as int).toDouble()
            : (map['rating'] ?? 0.0),
        photoUrl: map['photoUrl'],
      );

  // Convert → JSON (SharedPreferences)
  String toJson() => json.encode(toMap());

  // Convert JSON → Model
  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source));
}

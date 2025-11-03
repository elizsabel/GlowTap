import 'dart:convert';

/// Model data untuk menyimpan informasi akun customer.
/// Digunakan saat registrasi, login, dan pengelolaan profil.
class CustomerModel {
  int? id;            // ID unik (primary key) - otomatis dibuat oleh database    // Alamat / kota (tempat tinggal pengguna)
  String name;        // Nama lengkap pengguna
  String email;       // Email untuk login
  String phone;       // Nomor handphone
  String password;
  String city;    // Password akun

  CustomerModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.city,
  });

  /// Mengubah object CustomerModel menjadi Map (format yang dapat disimpan ke database).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'password': password,
      'city': city,
    };
  }

  /// Mengubah data Map (dari database) menjadi object CustomerModel.
  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'],                 // tidak perlu cek null, database akan otomatis generate
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
      city: map['city'],
    );
  }

  /// Mengubah object CustomerModel menjadi JSON (untuk keperluan penyimpanan lokal / API).
  String toJson() => json.encode(toMap());

  /// Mengubah JSON kembali menjadi object CustomerModel.
  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));
}



import 'dart:convert';

class UserModel {
  int? id;
  String username;
  String name;
  String email;
  String phone;
  String password;

  UserModel({
    this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username, // MASUKKAN
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'] ?? '', /// AMBIL DARI DATABASE
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}

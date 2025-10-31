import 'dart:convert';

class CustomerModel {
  int? id;
  String username;
  String name;
  String email;
  String phone;
  String password;

  CustomerModel({
    this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username' : username,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      username: map['username'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
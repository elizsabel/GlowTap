import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserFirebaseModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? createdAt;
  String? updatedAt;
  UserFirebaseModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UserFirebaseModel.fromMap(Map<String, dynamic> map) {
    return UserFirebaseModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFirebaseModel.fromJson(String source) =>
      UserFirebaseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

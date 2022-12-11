import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? email;
  final String? name;
  final String? noTelp;
  final String? password;
  final String? tglLahir;
  final int? type; // 1 = convensional, 2 = google, 3 = fb

  UserModel(
      {this.type,
      this.id,
      this.email,
      this.name,
      this.noTelp,
      this.password,
      this.tglLahir});

  Map genMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'noTelp': noTelp,
      'password': password,
      'tglLahir': tglLahir
    };
  }

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final Map map = doc.data() as Map;
    return UserModel(
        id: doc.id,
        type: map['type'] ?? 1,
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        noTelp: map['no_telp'] ?? '',
        password: map['password'] ?? '',
        tglLahir: map['tgl_lahir'] ?? '');
  }

  factory UserModel.fromMap(Map map) {
    return UserModel(
        id: map['id'] ?? '',
        type: map['type'] ?? 1,
        email: map['email'] ?? '',
        name: map['name'] ?? '',
        noTelp: map['no_telp'] ?? '',
        password: map['password'] ?? '',
        tglLahir: map['tgl_lahir'] ?? '');
  }
}

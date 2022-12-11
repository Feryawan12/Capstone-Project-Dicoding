import 'package:cloud_firestore/cloud_firestore.dart';

class KategoriModel {
  final String? id;
  final String? name;
  final String? keterangan;

  KategoriModel({this.id, this.name, this.keterangan});

  factory KategoriModel.fromFirestore(DocumentSnapshot doc) {
    final Map map = doc.data() as Map;
    return KategoriModel(
        id: doc.id,
        name: map['name'] ?? '',
        keterangan: map['keterangan'] ?? '');
  }

  factory KategoriModel.fromMap(Map map) {
    return KategoriModel(
        id: map['id'] ?? '',
        name: map['name'] ?? '',
        keterangan: map['keterangan'] ?? '');
  }
}

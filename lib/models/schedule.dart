import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule_app/models/kategori.dart';
import 'package:schedule_app/models/user.dart';

class ScheduleModel {
  final String? id;
  final String? name;
  final String? keterangan;
  final String? date;
  final String? time;
  final int? status;
  final String? kategoriId;
  final String? userId;
  final KategoriModel? kategoriRef;
  final UserModel? userRef;

  ScheduleModel(
      {this.id,
      this.name,
      this.status,
      this.keterangan,
      this.date,
      this.time,
      this.kategoriId,
      this.userId,
      this.kategoriRef,
      this.userRef});

  factory ScheduleModel.fromFirestore(DocumentSnapshot doc) {
    final Map map = doc.data() as Map;

    return ScheduleModel(
      id: doc.id,
      status: map['status'] ?? 0,
      name: map['name'] ?? '',
      keterangan: map['keterangan'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      kategoriId: map['kategori_id'] ?? '',
      userId: map['user_id'] ?? '',
      kategoriRef: map['kategori_ref'] != null
          ? KategoriModel.fromMap(map['kategori_ref'])
          : null,
      userRef:
          map['user_ref'] != null ? UserModel.fromMap(map['user_ref']) : null,
    );
  }
}

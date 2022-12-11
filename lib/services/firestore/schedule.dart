import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schedule_app/models/schedule.dart';

class ScheduleResponse {
  final bool isSucces;
  final ScheduleModel data;

  ScheduleResponse(this.isSucces, this.data);
}

class ScheduleStore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final GetStorage _box = GetStorage();

  static Future<ScheduleResponse> add(
      {required String name,
      required String keterangan,
      required String date,
      required String waktu,
      required DocumentSnapshot kategori,
      int status = 0}) async {
    try {
      await EasyLoading.show();
      final Map user = _box.read('user');
      final res = await _firestore.collection('schedule').add({
        'name': name,
        'keterangan': keterangan,
        'date': date,
        'time': waktu,
        'kategori_id': kategori.id,
        'user_id': user['id'],
        'kategori_ref': <String, dynamic>{
          'id': kategori.id,
          ...(kategori.data() as Map)
        },
        'user_ref': user,
        'status': status
      });

      if (!res.isBlank!) {
        final resData = await res.get();
        await EasyLoading.showSuccess('Schedule berhasil ditambah!');
        return ScheduleResponse(true, ScheduleModel.fromFirestore(resData));
      }

      await EasyLoading.showError('Schedule gagal ditambah!');
    } on SocketException catch (_) {
      Get.snackbar('Jaringan Hilang!',
          'Periksa jaringan anda atau nyalakan data/wifi anda',
          snackPosition: SnackPosition.BOTTOM);
    } on Error catch (e) {
      Get.snackbar(e.toString(), e.stackTrace.toString(),
          snackPosition: SnackPosition.BOTTOM, isDismissible: false);
    }

    return ScheduleResponse(false, ScheduleModel());
  }

  static Future<Iterable<ScheduleModel>> read(
      {String? kategoriId, int? status}) async {
    try {
      final Map user = _box.read('user');
      final res = await _firestore
          .collection('schedule')
          .where('user_id', isEqualTo: user['id'])
          .get();

      if (!res.isBlank!) {
        final List resData = res.docs;
        return resData
            .map((e) => ScheduleModel.fromFirestore(e))
            .toList()
            .reversed;
      }
    } on SocketException catch (_) {
      Get.snackbar('Jaringan Hilang!',
          'Periksa jaringan anda atau nyalakan data/wifi anda',
          snackPosition: SnackPosition.BOTTOM);
    } on Error catch (e) {
      Get.snackbar(e.toString(), e.stackTrace.toString(),
          snackPosition: SnackPosition.BOTTOM, isDismissible: false);
    }
    return [];
  }

  static Future<Iterable<ScheduleModel>> readBackground() async {
    try {
      final user = _box.read('user');

      if (user != null) {
        final res = await _firestore
            .collection('schedule')
            .where('date',
                isEqualTo: DateTime.now().toString().split(' ').first)
            .where('time',
                isEqualTo: '${DateTime.now().hour}:${DateTime.now().minute}')
            .where('status', isEqualTo: 0)
            .where('user_id', isEqualTo: user['id'])
            .get();

        if (!res.isBlank!) {
          final List resData = res.docs;
          return resData
              .map((e) => ScheduleModel.fromFirestore(e))
              .toList()
              .reversed;
        }
      }
    } on SocketException catch (_) {
      Get.snackbar('Jaringan Hilang!',
          'Periksa jaringan anda atau nyalakan data/wifi anda',
          snackPosition: SnackPosition.BOTTOM);
    } on Error catch (e) {
      Get.snackbar(e.toString(), e.stackTrace.toString(),
          snackPosition: SnackPosition.BOTTOM, isDismissible: false);
    }
    return [];
  }

  void delete(String idDoc) async {
    await EasyLoading.show();
    _firestore.collection('schedule').doc(idDoc).delete().then((value) async {
      await EasyLoading.showSuccess('Schedule sukses dihapus!');
    }).onError((error, stackTrace) async {
      await EasyLoading.dismiss();
      Get.snackbar(error.toString(), stackTrace.toString(),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }).printError();
  }
}

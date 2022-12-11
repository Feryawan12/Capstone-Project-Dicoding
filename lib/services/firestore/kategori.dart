import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import 'package:schedule_app/models/kategori.dart';

class KategoriStore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Iterable<KategoriModel>> read() async {
    try {
      final res = await _firestore.collection('kategoris').get();
      if (!res.isBlank!) {
        return res.docs
            .map((e) => KategoriModel.fromFirestore(e))
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
}

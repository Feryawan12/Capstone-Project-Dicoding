import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedule_app/models/user.dart';

class UserResponse {
  final bool isSucces;
  final UserModel data;

  UserResponse(this.isSucces, this.data);
}

class UserStore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserResponse> add(
      {required String name,
      required String password,
      required String tglLahir,
      required String email,
      required int type}) async {
    try {
      await EasyLoading.show();
      final res = await _firestore.collection('users').add({
        'name': name,
        'tgl_lahir': tglLahir,
        'password': password,
        'email': email,
        'type': type
      });

      if (!res.isBlank!) {
        final resData = await res.get();
        await EasyLoading.showSuccess('User berhasil ditambah!');
        return UserResponse(true, UserModel.fromFirestore(resData));
      }

      await EasyLoading.showError('User gagal ditambah!');
    } on SocketException catch (_) {
      Get.snackbar('Jaringan Hilang!',
          'Periksa jaringan anda atau nyalakan data/wifi anda',
          snackPosition: SnackPosition.BOTTOM);
    } on Error catch (e) {
      Get.snackbar(e.toString(), e.stackTrace.toString(),
          snackPosition: SnackPosition.BOTTOM, isDismissible: false);
    }
    return UserResponse(false, UserModel());
  }

  static Future<List<UserModel>> read({String? email, int? type}) async {
    try {
      final res = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('type', isEqualTo: type)
          .get();
      if (!res.isBlank!) {
        return res.docs.map((e) => UserModel.fromFirestore(e)).toList();
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

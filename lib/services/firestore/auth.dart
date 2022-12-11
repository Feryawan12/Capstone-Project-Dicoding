import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthStore {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final GetStorage _box = GetStorage();
  static Future<int> login(
      {required String email, required String password}) async {
    try {
      await EasyLoading.show();
      final res = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .where('type', isEqualTo: 1)
          .get();

      if (res.docs.isNotEmpty) {
        final resData = res.docs[0].data();
        resData.addAll({'id': res.docs[0].id});
        _box.write('user', resData);
        await EasyLoading.showSuccess('Selamat datang, ${resData['name']}');
        return 1;
      }

      await EasyLoading.showError(
          'Login gagal!\nAnda memasukan password atau email yang salah!');
    } on SocketException catch (_) {
      Get.snackbar('Jaringan Hilang!',
          'Periksa jaringan anda atau nyalakan data/wifi anda',
          snackPosition: SnackPosition.BOTTOM);
    } on Error catch (e) {
      Get.snackbar(e.toString(), e.stackTrace.toString(),
          snackPosition: SnackPosition.BOTTOM, isDismissible: false);
    }
    return 0;
  }

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    print('FB ID ADALAH ${loginResult.accessToken!.applicationId.toString()}');
    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}

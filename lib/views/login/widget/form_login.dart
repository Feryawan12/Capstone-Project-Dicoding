import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schedule_app/config/theme.dart';
import 'package:schedule_app/services/firestore/auth.dart';
import 'package:schedule_app/services/firestore/user.dart';
import 'package:schedule_app/views/mainScreen/main_screen.dart';
import 'package:schedule_app/views/register/register_page.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.4,
        margin: const EdgeInsets.symmetric(horizontal: 11.0),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 98.0),
              padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white),
              child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Email',
                            suffixIcon: Icon(Icons.email, size: 24)),
                      ),
                      const SizedBox(height: 11.0),
                      TextFormField(
                        controller: _password,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Password',
                            suffixIcon: Icon(Icons.lock, size: 24)),
                      ),
                      const SizedBox(height: 18.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_form.currentState!.validate()) {
                            AuthStore.login(
                                    email: _email.text,
                                    password: _password.text)
                                .then((value) {
                              if (value == 1) {
                                FlutterBackgroundService()
                                    .invoke("setAsForeground");

                                Get.off(() => const MainScreen());
                              }
                            });
                          }
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8.2),
                            width: MediaQuery.of(context).size.width,
                            child: Text('Login',
                                softWrap: true,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .labelLarge)),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        '-atau masuk menggunakan-',
                        softWrap: true,
                        style: ThemeApp.textStyleTheme(
                            color: Colors.grey[600],
                            isHead: false,
                            isLight: false,
                            size: 12.5),
                      ),
                      const SizedBox(height: 15.8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                AuthStore.signInWithGoogle().then((value) {
                                  if (value.user != null) {
                                    UserStore.read(
                                            email: value.user!.email, type: 2)
                                        .then((val) {
                                      if (val.isNotEmpty) {
                                        GetStorage()
                                            .write('user', val[0].genMap());
                                        FlutterBackgroundService()
                                            .invoke("setAsForeground");

                                        Get.off(() => const MainScreen());
                                      } else {
                                        UserStore.add(
                                                name: value.user!.displayName!,
                                                password: '',
                                                tglLahir: '',
                                                email: value.user!.email!,
                                                type: 2)
                                            .then((res) {
                                          if (res.isSucces) {
                                            GetStorage().write(
                                                'user', res.data.genMap());
                                            FlutterBackgroundService()
                                                .invoke("setAsForeground");

                                            Get.off(() => const MainScreen());
                                          }
                                        });
                                      }
                                    });
                                  } else {
                                    Get.snackbar('Login Google gagal!', '',
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                });
                              },
                              radius: 15.0,
                              child: Image.asset(
                                'assets/google_icon.png',
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 7.1,
                              )),
                          const SizedBox(width: 26.0),
                          InkWell(
                              onTap: () {
                                AuthStore.signInWithFacebook().then((value) {
                                  if (value.user != null) {
                                    UserStore.read(
                                            email: value.user!.email, type: 3)
                                        .then((val) {
                                      if (val.isNotEmpty) {
                                        GetStorage()
                                            .write('user', val[0].genMap());
                                        FlutterBackgroundService()
                                            .invoke("setAsForeground");

                                        Get.off(() => const MainScreen());
                                      } else {
                                        UserStore.add(
                                                name: value.user!.displayName!,
                                                password: '',
                                                tglLahir: '',
                                                email: value.user!.email!,
                                                type: 3)
                                            .then((res) {
                                          if (res.isSucces) {
                                            GetStorage().write(
                                                'user', res.data.genMap());
                                            FlutterBackgroundService()
                                                .invoke("setAsForeground");

                                            Get.off(() => const MainScreen());
                                          }
                                        });
                                      }
                                    });
                                  } else {
                                    Get.snackbar('Login Facebook gagal!', '',
                                        snackPosition: SnackPosition.BOTTOM);
                                  }
                                });
                              },
                              radius: 15.0,
                              child: Image.asset(
                                'assets/facebook_icon.png',
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 7.1,
                              )),
                        ],
                      ),
                      const SizedBox(height: 17.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum punya akun? ',
                            softWrap: true,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          InkWell(
                            onTap: () => Get.to(const RegisterPage()),
                            child: Text(
                              'Daftar',
                              softWrap: true,
                              style: ThemeApp.textStyleTheme(
                                  size: 14,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset('assets/gambar_meeting.png',
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width / 2.0),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:schedule_app/config/theme.dart';
import 'package:schedule_app/services/firestore/user.dart';

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _tglLahir = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 11.0),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 98.0),
              padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 18.0),
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
                        controller: _firstName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nama depan tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Nama Depan',
                            suffixIcon:
                                Icon(Icons.account_circle_rounded, size: 24)),
                      ),
                      const SizedBox(height: 11.0),
                      TextFormField(
                        controller: _lastName,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Nama belakang tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Nama Belakang',
                            suffixIcon: Icon(Icons.account_circle, size: 24)),
                      ),
                      const SizedBox(height: 11.0),
                      TextFormField(
                        controller: _tglLahir,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Tanggal lahir tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Tanggal Lahir',
                            suffixIcon: Icon(Icons.date_range, size: 24)),
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
                      const SizedBox(height: 11.0),
                      TextFormField(
                        controller: _confirmPw,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Konfirmasi password tidak boleh kosong!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Konfirmasi Password',
                            suffixIcon: Icon(Icons.lock, size: 24)),
                      ),
                      const SizedBox(height: 18.0),
                      ElevatedButton(
                        onPressed: () async {
                          if (_form.currentState!.validate()) {
                            if (_password.text == _confirmPw.text) {
                              UserStore.add(
                                      name:
                                          '${_firstName.text} ${_lastName.text}',
                                      password: _password.text,
                                      tglLahir: _tglLahir.text,
                                      email: _email.text,
                                      type: 1)
                                  .then((value) {
                                if (value.isSucces) {
                                  Get.back();
                                }
                              });
                            } else {
                              await EasyLoading.showError(
                                  'Konfirmasi password gagal!');
                            }
                          }
                        },
                        style: Theme.of(context).elevatedButtonTheme.style,
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 8.2),
                            width: MediaQuery.of(context).size.width,
                            child: Text('Sign Up',
                                softWrap: true,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .labelLarge)),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sudah punya akun? ',
                            softWrap: true,
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          InkWell(
                            onTap: () => Get.back(),
                            child: Text(
                              'Login',
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

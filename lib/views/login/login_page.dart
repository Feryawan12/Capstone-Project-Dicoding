import 'package:flutter/material.dart';
import 'package:schedule_app/views/globalWidgets/clip_path_curve.dart';
import 'package:schedule_app/views/login/widget/form_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
                clipper: ClipPathClass(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ))),
        const Align(
          alignment: Alignment.center,
          child: FormLogin(),
        )
      ],
    ));
  }
}

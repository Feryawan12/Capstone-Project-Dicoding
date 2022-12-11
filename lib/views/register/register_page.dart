import 'package:flutter/material.dart';
import 'package:schedule_app/views/globalWidgets/clip_path_curve.dart';
import 'package:schedule_app/views/register/widget/form_register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
          child: FormRegister(),
        )
      ],
    ));
  }
}

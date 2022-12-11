import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:schedule_app/config/theme.dart';
import 'package:schedule_app/states/schedule.dart';
import 'package:schedule_app/views/login/login_page.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GetStorage().read('user');

    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        leading: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 27,
              foregroundImage: AssetImage('assets/profile.png'),
            )),
        title: Text(user['name'],
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: Theme.of(context).primaryTextTheme.displayMedium),
        subtitle: Text(DateTime.now().toString().split(' ').first,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            style: Theme.of(context).primaryTextTheme.displaySmall),
        trailing: TextButton(
            onPressed: () async {
              ScheduleController.to.resetState();
              if (FirebaseAuth.instance.currentUser != null) {
                await FirebaseAuth.instance.signOut();
              }
              GetStorage().erase();
              Get.offAll(() => const LoginPage());
            },
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: Text(
              'Keluar',
              softWrap: true,
              style: ThemeApp.textStyleTheme(
                  color: Theme.of(context).colorScheme.primary, size: 11),
            )),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:schedule_app/models/schedule.dart';
import 'package:schedule_app/states/schedule.dart';
import 'package:schedule_app/views/mainScreen/main_screen.dart';

class EditSchedule extends StatefulWidget {
  final ScheduleModel? schedule;
  final int fromScreen;
  const EditSchedule({super.key, this.schedule, this.fromScreen = 0});

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  final GlobalKey<FormState> form = GlobalKey();
  TextEditingController name = TextEditingController();
  TextEditingController tglKegiatan = TextEditingController();
  TextEditingController kategori = TextEditingController();
  bool _status = false;

  @override
  void initState() {
    super.initState();
    _status = widget.schedule!.status! == 1;
    name = TextEditingController(text: widget.schedule!.name);
    tglKegiatan = TextEditingController(text: widget.schedule!.date);
    kategori = TextEditingController(text: widget.schedule!.kategoriRef!.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Ubah Tugas',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Form(
              key: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: kategori,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Kategori tidak boleh kosong!';
                      }
                      return null;
                    },
                    enabled: false,
                    decoration: const InputDecoration(
                        labelText: 'Label',
                        suffixIcon: Icon(Icons.work_outline, size: 24)),
                  ),
                  const SizedBox(height: 11.0),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama tugas tidak boleh kosong!';
                      }
                      return null;
                    },
                    enabled: false,
                    decoration: const InputDecoration(
                        labelText: 'Nama Tugas',
                        suffixIcon: Icon(Icons.work_outline, size: 24)),
                  ),
                  const SizedBox(height: 11.0),
                  TextFormField(
                    controller: tglKegiatan,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Tanggal tidak boleh kosong!';
                      }
                      return null;
                    },
                    enabled: false,
                    decoration: const InputDecoration(
                        labelText: 'Tanggal Event',
                        suffixIcon: Icon(Icons.calendar_today, size: 24)),
                  ),
                  const SizedBox(height: 11.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sudah mengerjakan tugas?',
                        softWrap: true,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Switch(
                        value: _status,
                        onChanged: (b) {
                          _status = !_status;
                          setState(() {});
                        },
                        activeColor: Colors.green,
                      )
                    ],
                  ),
                  const SizedBox(height: 14.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (form.currentState!.validate()) {
                        await EasyLoading.show();
                        FirebaseFirestore.instance
                            .collection('schedule')
                            .doc(widget.schedule!.id)
                            .update({'status': _status ? 1 : 0}).then(
                                (value) async {
                          await EasyLoading.showSuccess('Berhasil diupdate!');
                          ScheduleController.to.resetState();
                          ScheduleController.to.loadState();
                          Get.offAll(() => MainScreen(
                                index: widget.fromScreen,
                              ));
                        }).catchError((err) async {
                          await EasyLoading.showError('Gagal mengupdate!');
                        });
                      }
                    },
                    style: Theme.of(context).elevatedButtonTheme.style,
                    child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 8.2),
                        width: MediaQuery.of(context).size.width,
                        child: Text('Kirim',
                            softWrap: true,
                            style:
                                Theme.of(context).primaryTextTheme.labelLarge)),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

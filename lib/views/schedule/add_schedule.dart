import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedule_app/views/mainScreen/main_screen.dart';

import '../../services/firestore/kategori.dart';
import '../../services/firestore/schedule.dart';
import '../../states/schedule.dart';

class AddSchedule extends StatefulWidget {
  final int fromScreen;
  const AddSchedule({super.key, this.fromScreen = 0});

  @override
  State<AddSchedule> createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {
  final GlobalKey<FormState> form = GlobalKey();
  final TextEditingController name = TextEditingController();
  final TextEditingController tglKegiatan = TextEditingController();
  String idKategori = '';
  List<DropdownMenuItem> items = [];

  @override
  void initState() {
    super.initState();

    KategoriStore.read().then((value) {
      if (value.isNotEmpty) {
        items = value
            .map((e) => DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name!,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyMedium),
                ))
            .toList();
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Tambah Tugas',
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
                  DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return 'Label tidak boleh kosong!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Label Tugas',
                          suffixIcon: Icon(Icons.work_outline_sharp, size: 24)),
                      items: items,
                      onChanged: (val) =>
                          setState(() => idKategori = val as String)),
                  const SizedBox(height: 11.0),
                  TextFormField(
                    controller: name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Nama tugas tidak boleh kosong!';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        labelText: 'Nama Tugas',
                        suffixIcon: Icon(Icons.work_outline, size: 24)),
                  ),
                  const SizedBox(height: 11.0),
                  DateTimePicker(
                      type: DateTimePickerType.dateTime,
                      controller: tglKegiatan,
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 1)),
                      lastDate: DateTime(2100),
                      onChanged: (val) {},
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Tanggal tidak boleh kosong!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          labelText: 'Tanggal Event',
                          suffixIcon: Icon(Icons.calendar_today, size: 24))),
                  const SizedBox(height: 14.0),
                  ElevatedButton(
                    onPressed: () async {
                      if (form.currentState!.validate()) {
                        final dataKat = await FirebaseFirestore.instance
                            .collection('kategoris')
                            .doc(idKategori)
                            .get();

                        ScheduleStore.add(
                                name: name.text,
                                keterangan: '',
                                date: tglKegiatan.text.split(' ').first,
                                waktu: tglKegiatan.text.split(' ').last,
                                kategori: dataKat,
                                status: 0)
                            .then((value) {
                          if (value.isSucces) {
                            ScheduleController.to.resetState();
                            ScheduleController.to.loadState();
                            Get.offAll(
                                () => MainScreen(index: widget.fromScreen));
                          }
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

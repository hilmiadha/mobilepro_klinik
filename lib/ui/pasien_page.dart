import 'package:flutter/material.dart';
import '../model/pasien.dart';
import 'pasien_item.dart';
import 'pasien_form.dart';

class PasienPage extends StatefulWidget {
  const PasienPage({Key? key}) : super(key: key);

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Pasien",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            child: const Icon(Icons.add),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PasienForm()));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          PasienItem(pasien: Pasien(namaPasien: "Pasien 1")),
          PasienItem(pasien: Pasien(namaPasien: "Pasien 2")),
          PasienItem(pasien: Pasien(namaPasien: "Pasien 3")),
          PasienItem(pasien: Pasien(namaPasien: "Pasien 4")),
        ],
      ),
    );
  }
}

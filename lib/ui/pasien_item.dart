import 'package:flutter/material.dart';
import '../model/pasien.dart';
import 'pasien_detail.dart';

class PasienItem extends StatelessWidget {
  final Pasien pasien;

  const PasienItem({Key? key, required this.pasien}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PasienDetail(pasien: pasien)),
        );
      },
      child: Card(
        child: ListTile(
          title: Text("${pasien.namaPasien}"),
        ),
      ),
    );
  }
}

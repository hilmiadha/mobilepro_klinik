import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import 'pegawai_detail.dart';

class PegawaiItem extends StatelessWidget {
  final Pegawai pegawai;

  const PegawaiItem({Key? key, required this.pegawai}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PegawaiDetail(pegawai: pegawai)),
        );
      },
      child: Card(
        child: ListTile(
          title: Text("${pegawai.namaPegawai}"),
        ),
      ),
    );
  }
}

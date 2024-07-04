import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:klinik_app/ui/pegawai_page.dart';
import 'package:klinik_app/ui/pegawai_form_update.dart';
import '../model/pegawai.dart';
import '../service/pegawai_service.dart';

class PegawaiDetail extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiDetail({Key? key, required this.pegawai}) : super(key: key);

  @override
  State<PegawaiDetail> createState() => _PegawaiDetailState();
}

class _PegawaiDetailState extends State<PegawaiDetail> {
  Stream<Pegawai> getData() async* {
    Pegawai data = await PegawaiService().getById(widget.pegawai.id ?? '');
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Pegawai")),
      body: StreamBuilder<Pegawai>(
        stream: getData(),
        builder: (context, AsyncSnapshot<Pegawai> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Center(child: Text('Data Tidak Ditemukan'));
          }
          Pegawai pegawai = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildInfoRow("ID Pegawai", pegawai.id ?? 'N/A'),
                _buildInfoRow("Nama Pegawai", pegawai.namaPegawai),
                _buildInfoRow("NIP", pegawai.nip ?? 'N/A'),
                _buildInfoRow("Tanggal Lahir", pegawai.tanggalLahir ?? 'N/A'),
                _buildInfoRow("Nomor Telepon", pegawai.nomorTelepon ?? 'N/A'),
                _buildInfoRow("Email", pegawai.email ?? 'N/A'),
                _buildInfoRow("Password", pegawai.password ?? 'N/A'),
                _buildActionRow(pegawai),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$label:",
            style: TextStyle(fontSize: 20),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(Pegawai pegawai) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Implementasi logika ubah data
              _ubahData(pegawai);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Ubah"),
          ),
          ElevatedButton(
            onPressed: () {
              _hapusData(pegawai);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Hapus"),
          ),
        ],
      ),
    );
  }

  void _ubahData(Pegawai pegawai) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PegawaiFormUpdate(pegawai: pegawai),
      ),
    );
  }

  void _hapusData(Pegawai pegawai) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi"),
          content: Text("Yakin ingin menghapus data ini?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog konfirmasi
                _prosesHapusData(pegawai);
              },
              child: Text("Ya"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog konfirmasi
              },
              child: Text("Tidak"),
            ),
          ],
        );
      },
    );
  }

  void _prosesHapusData(Pegawai pegawai) async {
    try {
      await PegawaiService().hapus(pegawai).then((value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PegawaiPage()),
        );
        Fluttertoast.showToast(
          msg: "Data berhasil dihapus",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Gagal menghapus data: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:klinik_app/ui/poli_page.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import fluttertoast
import '../model/poli.dart';
import 'package:klinik_app/ui/poli_update_form.dart';
import '../service/poli_service.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;
  const PoliDetail({Key? key, required this.poli}) : super(key: key);

  @override
  State<PoliDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  Stream<Poli> getData() async* {
    Poli data = await PoliService().getById(widget.poli.id.toString());
    yield data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Poli',
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            setState(() {}); // Reload the page when back button is pressed.
          },
        ),
      ),
      body: StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return Text('Data Tidak Ditemukan');
          }
          return Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Nama Poli : ${snapshot.data.namaPoli}",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [_tombolUbah(), _tombolHapus(), _tombolLihatPoli()],
              )
            ],
          );
        },
      ),
    );
  }

  Widget _tombolUbah() {
    return StreamBuilder(
        stream: getData(),
        builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PoliUpdateForm(poli: snapshot.data)));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Ubah")));
  }

  Widget _tombolHapus() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            content: const Text("Yakin ingin menghapus data ini?"),
            actions: [
              // tombol ya
              StreamBuilder(
                  stream: getData(),
                  builder: (context, AsyncSnapshot snapshot) => ElevatedButton(
                        onPressed: () async {
                          await PoliService()
                              .hapus(snapshot.data)
                              .then((value) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PoliPage()));
                          });
                        },
                        child: const Text("YA"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      )),

              // tombol batal
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Tidak"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              )
            ],
          );
          showDialog(context: context, builder: (context) => alertDialog);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Hapus"));
  }

  Widget _tombolLihatPoli() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PoliPage(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      child: const Text("Lihat Poli"),
    );
  }

  void _hapusData() {
    // Lakukan logika hapus data di sini
    // Misalnya, setelah penghapusan data, tampilkan notifikasi
    Fluttertoast.showToast(
        msg: "Data berhasil dihapus",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
        textColor: Colors.white,
        fontSize: 16.0);

    // Kembali ke halaman sebelumnya (PoliPage)
    Navigator.pop(context);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => PoliPage()));
  }
}

import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import '../service/pegawai_service.dart';

class PegawaiFormUpdate extends StatefulWidget {
  final Pegawai pegawai;

  const PegawaiFormUpdate({Key? key, required this.pegawai}) : super(key: key);

  @override
  _PegawaiFormUpdateState createState() => _PegawaiFormUpdateState();
}

class _PegawaiFormUpdateState extends State<PegawaiFormUpdate> {
  final _formKey = GlobalKey<FormState>();
  final _namaPegawaiCtrl = TextEditingController();
  final _nipCtrl = TextEditingController();
  final _tanggalLahirCtrl = TextEditingController();
  final _nomorTeleponCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaPegawaiCtrl.text = widget.pegawai.namaPegawai;
    _nipCtrl.text = widget.pegawai.nip ?? '';
    _tanggalLahirCtrl.text = widget.pegawai.tanggalLahir ?? '';
    _nomorTeleponCtrl.text = widget.pegawai.nomorTelepon ?? '';
    _emailCtrl.text = widget.pegawai.email ?? '';
    _passwordCtrl.text = widget.pegawai.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Pegawai")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildFieldNamaPegawai(),
              _buildFieldNip(),
              _buildFieldTanggalLahir(),
              _buildFieldNomorTelepon(),
              _buildFieldEmail(),
              _buildFieldPassword(),
              const SizedBox(height: 20),
              _buildButtonSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldNamaPegawai() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Pegawai"),
      controller: _namaPegawaiCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nama Pegawai tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildFieldNip() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "NIP"),
      controller: _nipCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'NIP tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildFieldTanggalLahir() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Tanggal Lahir"),
      controller: _tanggalLahirCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Tanggal Lahir tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildFieldNomorTelepon() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nomor Telepon"),
      controller: _nomorTeleponCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Nomor Telepon tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildFieldEmail() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Email"),
      controller: _emailCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildFieldPassword() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Password"),
      controller: _passwordCtrl,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Password tidak boleh kosong';
        }
        return null;
      },
      obscureText: true,
    );
  }

  Widget _buildButtonSimpan() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Pegawai updatedPegawai = Pegawai(
            id: widget.pegawai.id,
            namaPegawai: _namaPegawaiCtrl.text,
            nip: _nipCtrl.text,
            tanggalLahir: _tanggalLahirCtrl.text,
            nomorTelepon: _nomorTeleponCtrl.text,
            email: _emailCtrl.text,
            password: _passwordCtrl.text,
          );
          _ubahData(updatedPegawai);
        }
      },
      child: const Text("Simpan"),
    );
  }

  void _ubahData(Pegawai pegawai) async {
    try {
      await PegawaiService().ubah(pegawai, pegawai.id ?? '').then((value) {
        Navigator.pop(
            context); // Kembali ke halaman sebelumnya setelah berhasil update
      });
    } catch (error) {
      print("Gagal mengubah data: $error");
      // Tambahkan penanganan kesalahan jika diperlukan
    }
  }

  @override
  void dispose() {
    // Clean up controllers
    _namaPegawaiCtrl.dispose();
    _nipCtrl.dispose();
    _tanggalLahirCtrl.dispose();
    _nomorTeleponCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }
}

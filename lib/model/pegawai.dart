class Pegawai {
  String? id;
  String? nip;
  String namaPegawai;
  String? tanggalLahir;
  String? nomorTelepon;
  String? email;
  String? password;

  Pegawai({
    this.id,
    this.nip,
    required this.namaPegawai,
    this.tanggalLahir,
    this.nomorTelepon,
    this.email,
    this.password,
  });

  factory Pegawai.fromJson(Map<String, dynamic> json) {
    return Pegawai(
      id: json['id'],
      nip: json['nip'],
      namaPegawai: json['nama'],
      tanggalLahir: json['tanggal_lahir'],
      nomorTelepon: json['nomor_telepon'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nip': nip,
      'nama': namaPegawai,
      'tanggal_lahir': tanggalLahir,
      'nomor_telepon': nomorTelepon,
      'email': email,
      'password': password,
    };
  }
}

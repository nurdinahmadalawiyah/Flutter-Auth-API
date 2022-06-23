// To parse this JSON data, do
//
//     final dataProdi = dataProdiFromJson(jsonString);

import 'dart:convert';

List<DataProdi> dataProdiFromJson(String str) => List<DataProdi>.from(json.decode(str).map((x) => DataProdi.fromJson(x)));

String dataProdiToJson(List<DataProdi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataProdi {
    DataProdi({
        required this.id,
        required this.nama,
        required this.nim,
        required this.prodi,
        required this.agama,
        required this.jnsKel,
        required this.alamat,
        required this.asalSekolah,
        required this.tahun,
        required this.tempatLahir,
        required this.tanggalLahir,
    });

    String id;
    String nama;
    String nim;
    String prodi;
    String agama;
    String jnsKel;
    String alamat;
    String asalSekolah;
    String tahun;
    String tempatLahir;
    DateTime tanggalLahir;

    factory DataProdi.fromJson(Map<String, dynamic> json) => DataProdi(
        id: json["id"],
        nama: json["nama"],
        nim: json["nim"],
        prodi: json["prodi"],
        agama: json["agama"],
        jnsKel: json["jns_kel"],
        alamat: json["alamat"],
        asalSekolah: json["asal_sekolah"],
        tahun: json["tahun"],
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: DateTime.parse(json["tanggal_lahir"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nim": nim,
        "prodi": prodi,
        "agama": agama,
        "jns_kel": jnsKel,
        "alamat": alamat,
        "asal_sekolah": asalSekolah,
        "tahun": tahun,
        "tempat_lahir": tempatLahir,
        "tanggal_lahir": "${tanggalLahir.year.toString().padLeft(4, '0')}-${tanggalLahir.month.toString().padLeft(2, '0')}-${tanggalLahir.day.toString().padLeft(2, '0')}",
    };
}
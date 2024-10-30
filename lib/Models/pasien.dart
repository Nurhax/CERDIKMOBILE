import 'dart:math';
import 'jadwal.dart';

class Pasien {
  String? username;
  String? password;
  String? email;
  String? id;

  int? usia;
  String? nama;
  String? gender;
  List<Map<String, dynamic>>? gejala;
  List<Map<Jadwal, dynamic>>? jadwalPasien;

  void CreateIDPasien() {
    id = Random(100000).toString();
  }
}

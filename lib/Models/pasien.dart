import 'dart:math';
import 'obat.dart';

class Pasien {
  String? username;
  String? password;
  String? email;
  String? id;

  int? usia;
  String? nama;
  String? gender;
  List<Map<String, dynamic>>? gejala;
  List<Map<Obat, dynamic>>? obatPasien;

  void CreateIDPasien() {
    id = Random(100000).toString();
  }
}

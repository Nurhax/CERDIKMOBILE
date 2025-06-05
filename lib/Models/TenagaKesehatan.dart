import 'dart:math';
import 'pasien.dart';

class Tenagakesehatan {
  String? Username;
  String? Password;
  String? Email;
  String? ID;
  String? Role;

  List<Map<Pasien, dynamic>>? PasienDirawat;

  void CreateIDNakes() {
    ID = Random(100000).toString();
  }
}

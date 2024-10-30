import 'dart:math';

class Obat {
  String? idObat;
  String? nama;
  String? jenis;
  String? saranPenyajian;

  void CreateIDObat() {
    idObat = Random(10000).toString();
  }
}

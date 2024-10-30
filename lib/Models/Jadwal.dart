import 'obat.dart';
class Jadwal {
  int? IDJadwal, IDPasien, IDObat;
  String? Gejala,Dosis,Start_Date,End_Date;
  bool? IsConfirmedNakes;

  List<Map<Obat, dynamic>>? obatPasien;
}
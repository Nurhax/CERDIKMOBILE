class JadwalObat {
  final String idJadwal; // Add this field
  final String idPasien;
  final String idObat;
  final String namaObat;
  final String gejala;
  final String dosis;
  final String startDate;
  final String endDate;
  final String waktuKonsumsi;
  final String jenisObat;
  final String deskripsi;
  String isConfirmedNakes;
  final String frekuensi;

  JadwalObat({
    required this.idJadwal, 
    required this.idPasien,
    required this.idObat,
    required this.namaObat,
    required this.gejala,
    required this.dosis,
    required this.startDate,
    required this.endDate,
    required this.waktuKonsumsi,
    required this.jenisObat,
    required this.deskripsi,
    required this.isConfirmedNakes,
    required this.frekuensi,
  });

  factory JadwalObat.fromJson(Map<String, dynamic> json) {
    return JadwalObat(
      idJadwal: json['IDJadwal'] ?? '', 
      idPasien: json['IDPasien'],
      idObat: json['IDObat'],
      namaObat: json['NamaObat'] ?? '',
      gejala: json['Gejala'] ?? '',
      dosis: json['Dosis'] ?? '',
      startDate: json['Start_Date'] ?? '',
      endDate: json['End_Date'] ?? '',
      waktuKonsumsi: json['WaktuKonsumsi'] ?? '',
      jenisObat: json['JenisObat'] ?? '',
      deskripsi: json['Deskripsi'] ?? '',
      isConfirmedNakes: json['IsConfirmedNakes'] ?? '',
      frekuensi: json['Frekuensi'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'IDJadwal': idJadwal, 
      'IDPasien': idPasien,
      'IDObat': idObat,
      'NamaObat': namaObat,
      'Gejala': gejala,
      'Dosis': dosis,
      'Start_Date': startDate,
      'End_Date': endDate,
      'WaktuKonsumsi': waktuKonsumsi,
      'JenisObat': jenisObat,
      'Deskripsi': deskripsi,
      'IsConfirmedNakes': isConfirmedNakes,
      'Frekuensi': frekuensi,
    };
  }
}

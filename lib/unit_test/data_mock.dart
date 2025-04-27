// Mock data for testing
class MockData {
  // Mock Obat data
  static Map<String, dynamic> getMockObatJson() {
    return {
      "idobat": "1",
      "namaobat": "Paracetamol",
      "jenisObat": "Tablet",
      "deskripsiObat": "Obat untuk meredakan demam dan nyeri",
      "gejalaObat": "Demam, Sakit kepala",
      "ukuran": "500mg"
    };
  }

  // Mock Pasien data
  static Map<String, dynamic> getMockPasienJson() {
    return {
      "idpasien": "1",
      "username": "patient1",
      "email": "patient1@example.com",
      "usia": "30",
      "nama": "John Doe",
      "gender": "Laki-laki",
      "idnakes": "101"
    };
  }

  // Mock JadwalObat data
  static Map<String, dynamic> getMockJadwalObatJson() {
    return {
      "IDJadwal": "1",
      "IDPasien": "1",
      "IDObat": "1",
      "NamaObat": "Paracetamol",
      "Gejala": "Demam",
      "Dosis": "1 tablet",
      "Start_Date": "2025-04-01",
      "End_Date": "2025-04-10",
      "WaktuKonsumsi": "08:00",
      "JenisObat": "Tablet",
      "Deskripsi": "Diminum setelah makan",
      "IsConfirmedNakes": "1",
      "Frekuensi": "3x1"
    };
  }

  // Mock JadwalObat list
  static List<Map<String, dynamic>> getMockJadwalObatListJson() {
    return [
      getMockJadwalObatJson(),
      {
        "IDJadwal": "2",
        "IDPasien": "1",
        "IDObat": "2",
        "NamaObat": "Amoxicillin",
        "Gejala": "Infeksi",
        "Dosis": "1 kapsul",
        "Start_Date": "2025-04-02",
        "End_Date": "2025-04-12",
        "WaktuKonsumsi": "12:00",
        "JenisObat": "Kapsul",
        "Deskripsi": "Diminum sebelum makan",
        "IsConfirmedNakes": "0",
        "Frekuensi": "2x1"
      }
    ];
  }

  // Mock Pasien list
  static List<Map<String, dynamic>> getMockPasienListJson() {
    return [
      getMockPasienJson(),
      {
        "idpasien": "2",
        "username": "patient2",
        "email": "patient2@example.com",
        "usia": "25",
        "nama": "Jane Smith",
        "gender": "Perempuan",
        "idnakes": "101"
      }
    ];
  }

  // Mock API responses
  static String getMockJadwalListResponse() {
    return '''
    [
      {
        "IDJadwal": "1",
        "IDPasien": "1",
        "IDObat": "1",
        "NamaObat": "Paracetamol",
        "Gejala": "Demam",
        "Dosis": "1 tablet",
        "Start_Date": "2025-04-01",
        "End_Date": "2025-04-10",
        "WaktuKonsumsi": "08:00",
        "JenisObat": "Tablet",
        "Deskripsi": "Diminum setelah makan",
        "IsConfirmedNakes": "1",
        "Frekuensi": "3x1"
      },
      {
        "IDJadwal": "2",
        "IDPasien": "1",
        "IDObat": "2",
        "NamaObat": "Amoxicillin",
        "Gejala": "Infeksi",
        "Dosis": "1 kapsul",
        "Start_Date": "2025-04-02",
        "End_Date": "2025-04-12",
        "WaktuKonsumsi": "12:00",
        "JenisObat": "Kapsul",
        "Deskripsi": "Diminum sebelum makan",
        "IsConfirmedNakes": "0",
        "Frekuensi": "2x1"
      }
    ]
    ''';
  }

  static String getMockSuccessResponse() {
    return '{"success": "true"}';
  }

  static String getMockErrorResponse() {
    return '{"success": "false", "error": "Error message"}';
  }
}

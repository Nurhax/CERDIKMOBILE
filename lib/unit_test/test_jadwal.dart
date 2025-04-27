import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/models/jadwal.dart';
import 'data_mock.dart';
import 'dart:convert';

void main() {
  group('JadwalObat Model Tests', () {
    test('fromJson creates JadwalObat object correctly', () {
      // Arrange
      final Map<String, dynamic> jsonData = MockData.getMockJadwalObatJson();

      // Act
      final jadwalObat = JadwalObat.fromJson(jsonData);

      // Assert
      expect(jadwalObat.idJadwal, equals(jsonData['IDJadwal']));
      expect(jadwalObat.idPasien, equals(jsonData['IDPasien']));
      expect(jadwalObat.idObat, equals(jsonData['IDObat']));
      expect(jadwalObat.namaObat, equals(jsonData['NamaObat']));
      expect(jadwalObat.gejala, equals(jsonData['Gejala']));
      expect(jadwalObat.dosis, equals(jsonData['Dosis']));
      expect(jadwalObat.startDate, equals(jsonData['Start_Date']));
      expect(jadwalObat.endDate, equals(jsonData['End_Date']));
      expect(jadwalObat.waktuKonsumsi, equals(jsonData['WaktuKonsumsi']));
      expect(jadwalObat.jenisObat, equals(jsonData['JenisObat']));
      expect(jadwalObat.deskripsi, equals(jsonData['Deskripsi']));
      expect(jadwalObat.isConfirmedNakes, equals(jsonData['IsConfirmedNakes']));
      expect(jadwalObat.frekuensi, equals(jsonData['Frekuensi']));
    });

    test('toJson converts JadwalObat object to JSON correctly', () {
      // Arrange
      final jadwalObat = JadwalObat(
          idJadwal: '1',
          idPasien: '1',
          idObat: '1',
          namaObat: 'Paracetamol',
          gejala: 'Demam',
          dosis: '1 tablet',
          startDate: '2025-04-01',
          endDate: '2025-04-10',
          waktuKonsumsi: '08:00',
          jenisObat: 'Tablet',
          deskripsi: 'Diminum setelah makan',
          isConfirmedNakes: '1',
          frekuensi: '3x1');

      // Act
      final jsonData = jadwalObat.toJson();

      // Assert
      expect(jsonData['IDJadwal'], equals(jadwalObat.idJadwal));
      expect(jsonData['IDPasien'], equals(jadwalObat.idPasien));
      expect(jsonData['IDObat'], equals(jadwalObat.idObat));
      expect(jsonData['NamaObat'], equals(jadwalObat.namaObat));
      expect(jsonData['Gejala'], equals(jadwalObat.gejala));
      expect(jsonData['Dosis'], equals(jadwalObat.dosis));
      expect(jsonData['Start_Date'], equals(jadwalObat.startDate));
      expect(jsonData['End_Date'], equals(jadwalObat.endDate));
      expect(jsonData['WaktuKonsumsi'], equals(jadwalObat.waktuKonsumsi));
      expect(jsonData['JenisObat'], equals(jadwalObat.jenisObat));
      expect(jsonData['Deskripsi'], equals(jadwalObat.deskripsi));
      expect(jsonData['IsConfirmedNakes'], equals(jadwalObat.isConfirmedNakes));
      expect(jsonData['Frekuensi'], equals(jadwalObat.frekuensi));
    });

    test('handles empty or null values in fromJson', () {
      // Arrange
      final Map<String, dynamic> jsonData = {
        'IDJadwal': '1',
        'IDPasien': '1',
        'IDObat': '1',
        // Missing other fields to test null/empty handling
      };

      // Act
      final jadwalObat = JadwalObat.fromJson(jsonData);

      // Assert
      expect(jadwalObat.idJadwal, equals('1'));
      expect(jadwalObat.idPasien, equals('1'));
      expect(jadwalObat.idObat, equals('1'));
      expect(jadwalObat.namaObat, equals(''));
      expect(jadwalObat.gejala, equals(''));
      expect(jadwalObat.dosis, equals(''));
      expect(jadwalObat.startDate, equals(''));
      expect(jadwalObat.endDate, equals(''));
      expect(jadwalObat.waktuKonsumsi, equals(''));
      expect(jadwalObat.jenisObat, equals(''));
      expect(jadwalObat.deskripsi, equals(''));
      expect(jadwalObat.isConfirmedNakes, equals(''));
      expect(jadwalObat.frekuensi, equals(''));
    });
  });
}

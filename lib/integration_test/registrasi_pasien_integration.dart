import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/registrasi_pasien.dart'; // Ganti sesuai dengan lokasi file Anda
import 'package:tubes/login.dart'; // Ganti dengan lokasi file Login Anda
import 'package:tubes/pagePasien.dart'; // Ganti dengan lokasi file pagePasien Anda
import 'package:tubes/models/pasien.dart'; // Ganti dengan lokasi model Pasien Anda

void main() {
  group('Integration Test: Register to Login to Home', () {
    testWidgets('Registers, logs in, and navigates to home page',
        (WidgetTester tester) async {
      // Dummy data untuk registrasi
      const username = 'dummy_user';
      const password = 'dummy_password';
      const email = 'dummy_user@example.com';
      const namaLengkap = 'Dummy Pasien';
      const tanggalLahir = '01/01/2000';
      const jenisKelamin = 'L';

      // Dummy data untuk Pasien setelah login
      final dummyPasien = Pasien.api(
        id: '123',
        username: username,
        email: email,
        usia: '23',
        nama: namaLengkap,
        gender: jenisKelamin,
        idnakes: '456',
      );

      // Simulasikan registrasi
      await tester.pumpWidget(MaterialApp(
          home: RegistrasiPasien(
        someCondition: true,
      )));

      await tester.enterText(find.byType(TextField).at(0), username);
      await tester.enterText(find.byType(TextField).at(1), namaLengkap);
      await tester.enterText(find.byType(TextField).at(2), email);
      await tester.enterText(find.byType(TextField).at(3), password);
      await tester.enterText(find.byType(TextField).at(4), tanggalLahir);
      await tester.enterText(find.byType(TextField).at(5), jenisKelamin);

      await tester.tap(find.text('Daftar'));
      await tester.pumpAndSettle();

      // Verifikasi bahwa diarahkan ke halaman Login
      expect(find.byType(Login), findsOneWidget);

      // Simulasikan login
      await tester.enterText(find.byType(TextField).at(0), username);
      await tester.enterText(find.byType(TextField).at(1), password);
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Simulasikan navigasi ke pagePasien setelah login berhasil
      await tester.pumpWidget(
          MaterialApp(home: pagePasien(pasienSaatIni: dummyPasien)));
      await tester.pumpAndSettle();
    });
  });
}

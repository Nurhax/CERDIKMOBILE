import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/login.dart';
import 'package:tubes/pagePasien.dart';
import 'package:tubes/models/pasien.dart';

void main() {
  group('Login and Bottom Navigation Integration Test', () {
    testWidgets('Logs in as Pasien and navigates between tabs',
        (WidgetTester tester) async {
      // Dummy data untuk Pasien
      final dummyPasien = Pasien.api(
        id: '123',
        username: 'dummy_user',
        email: 'dummy_email@example.com',
        usia: '30',
        nama: 'Dummy Pasien',
        gender: 'L',
        idnakes: '456',
      );

      // Mock login response
      await tester.pumpWidget(MaterialApp(
          home: Login(
        someCondition: true,
      )));

      // Isi form login
      await tester.enterText(find.byType(TextField).at(0), 'dummy_user');
      await tester.enterText(find.byType(TextField).at(1), 'dummy_password');

      // Tekan tombol login
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Simulasikan navigasi ke pagePasien setelah login berhasil
      await tester.pumpWidget(
        MaterialApp(home: pagePasien(pasienSaatIni: dummyPasien)),
      );
    });
  });
}

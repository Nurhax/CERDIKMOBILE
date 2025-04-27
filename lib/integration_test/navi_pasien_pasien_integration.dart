import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/pagePasien.dart'; // Ganti dengan nama paket Anda
import 'package:tubes/models/pasien.dart'; // Ganti sesuai lokasi model Pasien

void main() {
  group('Bottom Navigation Integration Test', () {
    testWidgets('Navigates correctly between tabs',
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

      // Jalankan widget
      await tester.pumpWidget(
        MaterialApp(
          home: pagePasien(pasienSaatIni: dummyPasien),
        ),
      );

      // Verifikasi halaman awal adalah BerandaPasien
      expect(find.byType(BerandaPasien), findsOneWidget);
      expect(find.byType(jadwalPasienPage), findsNothing);
      expect(find.byType(profilePasien), findsNothing);

      // Navigasi ke jadwalPasienPage
      await tester.tap(find.byIcon(Icons.calendar_month));
      await tester.pumpAndSettle();
      expect(find.byType(BerandaPasien), findsNothing);
      expect(find.byType(jadwalPasienPage), findsOneWidget);
      expect(find.byType(profilePasien), findsNothing);

      // Navigasi ke profilePasien
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();
      expect(find.byType(BerandaPasien), findsNothing);
      expect(find.byType(jadwalPasienPage), findsNothing);
      expect(find.byType(profilePasien), findsOneWidget);

      // Kembali ke BerandaPasien
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      expect(find.byType(BerandaPasien), findsOneWidget);
      expect(find.byType(jadwalPasienPage), findsNothing);
      expect(find.byType(profilePasien), findsNothing);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/pageDokter.dart'; // Ubah sesuai nama paket Anda
import 'package:tubes/models/nakes.dart'; // Ubah sesuai lokasi model Nakes Anda

void main() {
  group('Bottom Navigation Integration Test', () {
    testWidgets('Navigates to correct page on BottomNavigationBar tap',
        (WidgetTester tester) async {
      // Buat instance dummy untuk Nakes
      final dummyNakes = Nakes()
        ..id = '1'
        ..username = 'dummy_user'
        ..namaLengkap = 'Dummy Nakes'
        ..password = 'dummy_password'
        ..email = 'dummy_email@example.com'
        ..nomorSTR = '123456789'
        ..PasienDirawat = [];

      // Pasang widget pageDokter dengan dummy Nakes
      await tester.pumpWidget(
        MaterialApp(
          home: pageDokter(nakesSaatIni: dummyNakes),
        ),
      );

      // Verifikasi halaman awal
      expect(find.byType(dataPasienPage), findsOneWidget);
      expect(find.byType(tambahPasienPage), findsNothing);
      expect(find.byType(tambahObatPage), findsNothing);
      expect(find.byType(morePage), findsNothing);

      // Navigasi ke tambahPasienPage
      await tester.tap(find.byIcon(Icons.calendar_month));
      await tester.pumpAndSettle();
      expect(find.byType(tambahPasienPage), findsOneWidget);

      // Navigasi ke tambahObatPage
      await tester.tap(find.byIcon(Icons.all_inbox));
      await tester.pumpAndSettle();
      expect(find.byType(tambahObatPage), findsOneWidget);

      // Navigasi ke morePage
      await tester.tap(find.byIcon(Icons.more_horiz));
      await tester.pumpAndSettle();
      expect(find.byType(morePage), findsOneWidget);

      // Kembali ke BerandaPasien
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();
      expect(find.byType(dataPasienPage), findsOneWidget);
      expect(find.byType(tambahPasienPage), findsNothing);
      expect(find.byType(tambahObatPage), findsNothing);
      expect(find.byType(morePage), findsNothing);
    });
  });
}

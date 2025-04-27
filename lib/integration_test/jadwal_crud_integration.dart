import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
// import 'package:tubes/models/jadwal.dart';
// import 'package:tubes/models/manage_jadwal.dart';
// import 'package:tubes/jadwalView/homeJadwal.dart';
// import 'package:tubes/jadwalView/showInputScreen.dart';
// import 'package:tubes/jadwalView/updateInputScreen.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tubes/models/pasien.dart';
import 'package:tubes/pagePasien.dart';
// import 'dart:convert';
import '../unit_test/data_mock.dart';

void main() {
  group('Jadwal CRUD Integration Tests', () {
    // This is a simplified integration test that would need to be adapted
    // to work with the actual implementation. In a real test environment,
    // you would need to:
    // 1. Mock the HTTP client
    // 2. Provide the necessary dependencies
    // 3. Set up a test environment that can handle API calls

    testWidgets('Jadwal list loads and displays correctly',
        (WidgetTester tester) async {
      // Mock HTTP client to return test data
      final mockClient = MockClient((request) async {
        if (request.url.toString().contains('get_jadwal.php')) {
          return http.Response(MockData.getMockJadwalListResponse(), 200);
        }
        return http.Response('Not found', 404);
      });

      // Build the widget that displays jadwal list
      // Note: This is a simplified test. In a real test, you would need to
      // inject the mock client into your widget tree.
      await tester.pumpWidget(MaterialApp(
          home: BerandaPasien(
              pasienSaatIni: Pasien.api(
                  id: "1",
                  idnakes: "2",
                  email: "iqbalnur@gmail.com",
                  gender: "L",
                  nama: "Iqbal",
                  username: "Nurhax",
                  usia: "21"))));

      // Wait for the data to load
      await tester.pump(Duration(seconds: 2));

      // Verify that the jadwal list is displayed
      expect(find.text('Esomeprazole'), findsOneWidget);
      expect(find.text('Sebelum Makan'), findsOneWidget);
      expect(find.text('Cetirizine'), findsOneWidget);
      expect(find.text('1 Tablet'), findsOneWidget);
    });

    // testWidgets('Add new jadwal works correctly', (WidgetTester tester) async {
    //   // Mock HTTP client to return success response
    //   final mockClient = MockClient((request) async {
    //     if (request.url.toString().contains('insert_jadwal.php')) {
    //       return http.Response('{"success": "true"}', 200);
    //     }
    //     return http.Response('Not found', 404);
    //   });

    //   // Build the widget that allows adding jadwal
    //   // Note: This is a simplified test. In a real test, you would need to
    //   // inject the mock client into your widget tree.
    //   await tester.pumpWidget(MaterialApp(
    //     routes: {
    //       '/showInputScreen': (context) => ShowInputScreen(),
    //     },
    //     home: HomeJadwal(),
    //   ));

    //   // Find and tap the add button
    //   await tester.tap(find.byIcon(Icons.add));
    //   await tester.pumpAndSettle();

    //   // Verify we're on the input screen
    //   expect(find.byType(ShowInputScreen), findsOneWidget);

    //   // Fill in the form fields
    //   await tester.enterText(find.byType(TextField).at(0), 'Paracetamol');
    //   await tester.enterText(find.byType(TextField).at(1), 'Demam');
    //   await tester.enterText(find.byType(TextField).at(2), '1 tablet');
    //   // ... fill in other fields

    //   // Submit the form
    //   await tester.tap(find.text('Simpan'));
    //   await tester.pumpAndSettle();

    //   // Verify success message or navigation back to list
    //   expect(find.text('Berhasil menambahkan jadwal'), findsOneWidget);
    // });

    // testWidgets('Edit jadwal works correctly', (WidgetTester tester) async {
    //   // Mock HTTP client to return success response
    //   final mockClient = MockClient((request) async {
    //     if (request.url.toString().contains('update_jadwal.php')) {
    //       return http.Response('{"success": "true"}', 200);
    //     }
    //     return http.Response('Not found', 404);
    //   });

    //   // Build the widget that displays jadwal list
    //   await tester.pumpWidget(MaterialApp(
    //     routes: {
    //       '/updateInputScreen': (context) => UpdateInputScreen(),
    //     },
    //     home: HomeJadwal(),
    //   ));

    //   // Find and tap the edit button for a jadwal
    //   await tester.tap(find.byIcon(Icons.edit).first);
    //   await tester.pumpAndSettle();

    //   // Verify we're on the update screen
    //   expect(find.byType(UpdateInputScreen), findsOneWidget);

    //   // Update the form fields
    //   await tester.enterText(find.byType(TextField).at(0), 'Updated Medicine');

    //   // Submit the form
    //   await tester.tap(find.text('Update'));
    //   await tester.pumpAndSettle();

    //   // Verify success message or navigation back to list
    //   expect(find.text('Berhasil mengupdate jadwal'), findsOneWidget);
    // });

    // testWidgets('Delete jadwal works correctly', (WidgetTester tester) async {
    //   // Mock HTTP client to return success response
    //   final mockClient = MockClient((request) async {
    //     if (request.url.toString().contains('delete_jadwal.php')) {
    //       return http.Response('{"success": "true"}', 200);
    //     }
    //     return http.Response('Not found', 404);
    //   });

    //   // Build the widget that displays jadwal list
    //   await tester.pumpWidget(MaterialApp(home: HomeJadwal()));

    //   // Find and tap the delete button for a jadwal
    //   await tester.tap(find.byIcon(Icons.delete).first);
    //   await tester.pumpAndSettle();

    //   // Confirm deletion
    //   await tester.tap(find.text('Ya'));
    //   await tester.pumpAndSettle();

    //   // Verify success message
    //   expect(find.text('Berhasil menghapus jadwal'), findsOneWidget);
    // });
  });
}

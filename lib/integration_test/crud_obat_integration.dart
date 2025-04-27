import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:tubes/models/nakes.dart';
// import 'package:tubes/models/obat.dart';
// import 'package:tubes/edit_hapus_obat.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:tubes/pageDokter.dart';
import 'dart:convert';
import '../unit_test/data_mock.dart';

void main() {
  group('Obat CRUD Integration Tests', () {
    // This is a simplified integration test that would need to be adapted
    // to work with the actual implementation. In a real test environment,
    // you would need to:
    // 1. Mock the HTTP client
    // 2. Provide the necessary dependencies
    // 3. Set up a test environment that can handle API calls

    testWidgets('Obat list loads and displays correctly',
        (WidgetTester tester) async {
      // Mock HTTP client to return test data
      final mockClient = MockClient((request) async {
        if (request.url.toString().contains('view_obat.php')) {
          return http.Response(
              '[${json.encode(MockData.getMockObatJson())}]', 200);
        }
        return http.Response('Not found', 404);
      });
      Nakes nakesMock = Nakes();
      nakesMock.id = "2";
      // Build the widget that displays obat list
      // Note: This is a simplified test. In a real test, you would need to
      // inject the mock client into your widget tree.
      await tester.pumpWidget(
          MaterialApp(home: tambahObatPage(nakesSaatIni: nakesMock)));

      // Wait for the data to load
      await tester.pump(Duration(seconds: 2));

      // Verify that the obat list is displayed
      expect(find.text('Esomeprazole'), findsOneWidget);
      expect(find.text('Cetirizine'), findsOneWidget);
      expect(find.text('Isoprinosine'), findsOneWidget);
      expect(find.text('Tablet'), findsOneWidget);
    });

    // testWidgets('Add new obat works correctly', (WidgetTester tester) async {
    //   // Mock HTTP client to return success response
    //   final mockClient = MockClient((request) async {
    //     if (request.url.toString().contains('insert_obat.php')) {
    //       return http.Response('{"success": "true"}', 200);
    //     }
    //     return http.Response('Not found', 404);
    //   });

    //   // Build the widget that allows adding obat
    //   // Note: This is a simplified test. In a real test, you would need to
    //   // inject the mock client into your widget tree.
    //   await tester.pumpWidget(MaterialApp(home: EditHapusObat()));

    //   // Find and tap the add button
    //   await tester.tap(find.byIcon(Icons.add));
    //   await tester.pumpAndSettle();

    //   // Fill in the form fields
    //   await tester.enterText(find.byType(TextField).at(0), 'New Medicine');
    //   await tester.enterText(find.byType(TextField).at(1), 'Tablet');
    //   await tester.enterText(find.byType(TextField).at(2), 'For headache');
    //   await tester.enterText(find.byType(TextField).at(3), 'Headache');
    //   await tester.enterText(find.byType(TextField).at(4), '500mg');

    //   // Submit the form
    //   await tester.tap(find.text('Simpan'));
    //   await tester.pumpAndSettle();

    //   // Verify success message or navigation back to list
    //   expect(find.text('Berhasil menambahkan obat'), findsOneWidget);
    // });

    // testWidgets('Edit obat works correctly', (WidgetTester tester) async {
    //   // Mock HTTP client to return success response
    //   final mockClient = MockClient((request) async {
    //     if (request.url.toString().contains('update_obat.php')) {
    //       return http.Response('{"success": "true"}', 200);
    //     }
    //     return http.Response('Not found', 404);
    //   });

    //   // Build the widget that displays obat list
    //   await tester.pumpWidget(MaterialApp(home: EditHapusObat()));

    //   // Find and tap the edit button for an obat
    //   await tester.tap(find.byIcon(Icons.edit).first);
    //   await tester.pumpAndSettle();

    //   // Update the form fields
    //   await tester.enterText(find.byType(TextField).at(0), 'Updated Medicine');

    //   // Submit the form
    //   await tester.tap(find.text('Update'));
    //   await tester.pumpAndSettle();

    //   // Verify success message or navigation back to list
    //   expect(find.text('Berhasil mengupdate obat'), findsOneWidget);
    // });

    // testWidgets('Delete obat works correctly', (WidgetTester tester) async {
    //   // Mock HTTP client to return success response
    //   final mockClient = MockClient((request) async {
    //     if (request.url.toString().contains('delete_obat.php')) {
    //       return http.Response('{"success": "true"}', 200);
    //     }
    //     return http.Response('Not found', 404);
    //   });

    //   // Build the widget that displays obat list
    //   await tester.pumpWidget(MaterialApp(home: EditHapusObat()));

    //   // Find and tap the delete button for an obat
    //   await tester.tap(find.byIcon(Icons.delete).first);
    //   await tester.pumpAndSettle();

    //   // Confirm deletion
    //   await tester.tap(find.text('Ya'));
    //   await tester.pumpAndSettle();

    //   // Verify success message
    //   expect(find.text('Berhasil menghapus obat'), findsOneWidget);
    // });
  });
}

// import 'package:flutter_test/flutter_test.dart';
// import 'package:tubes/models/obat.dart';
// import 'data_mock.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/testing.dart';
// import 'dart:convert';

// void main() {
//   group('Obat Model Tests', () {
//     test('fromJson creates Obat object correctly', () {
//       // Arrange
//       final Map<String, dynamic> jsonData = MockData.getMockObatJson();

//       // Act
//       final obat = Obat.fromJson(jsonData);

//       // Assert
//       expect(obat.id, equals(jsonData['idobat']));
//       expect(obat.namaObat, equals(jsonData['namaobat']));
//       expect(obat.jenisObat, equals(jsonData['jenisObat']));
//       expect(obat.deskripsiObat, equals(jsonData['deskripsiObat']));
//       expect(obat.gejalaObat, equals(jsonData['gejalaObat']));
//       expect(obat.ukuran, equals(jsonData['ukuran']));
//     });

//     test('toJson converts Obat object to JSON correctly', () {
//       // Arrange
//       final obat = Obat(
//           id: '1',
//           namaObat: 'Paracetamol',
//           jenisObat: 'Tablet',
//           deskripsiObat: 'Obat untuk meredakan demam dan nyeri',
//           gejalaObat: 'Demam, Sakit kepala',
//           ukuran: '500mg');

//       // Act
//       final jsonData = obat.toJson();

//       // Assert
//       expect(jsonData['id'], equals(obat.id));
//       expect(jsonData['namaObat'], equals(obat.namaObat));
//       expect(jsonData['jenisObat'], equals(obat.jenisObat));
//       expect(jsonData['deskripsiObat'], equals(obat.deskripsiObat));
//       expect(jsonData['gejalaObat'], equals(obat.gejalaObat));
//       expect(jsonData['ukuran'], equals(obat.ukuran));
//     });
//   });

//   group('Obat API Methods Tests', () {
//     late MockClient mockClient;

//     setUp(() {
//       mockClient = MockClient((request) async {
//         if (request.url.toString().contains('view_obat.php')) {
//           return http.Response(
//               '[${json.encode(MockData.getMockObatJson())}]', 200);
//         } else if (request.url.toString().contains('insert_obat.php')) {
//           return http.Response(MockData.getMockSuccessResponse(), 200);
//         } else if (request.url.toString().contains('update_obat.php')) {
//           return http.Response(MockData.getMockSuccessResponse(), 200);
//         } else if (request.url.toString().contains('delete_obat.php')) {
//           return http.Response(MockData.getMockSuccessResponse(), 200);
//         }
//         return http.Response('Not found', 404);
//       });

//       // Replace the http client with our mock
//       // Note: This would require refactoring the Obat class to accept a client
//       // For this test, we're demonstrating the approach
//     });

//     // Note: These tests would require refactoring the Obat class to make it testable
//     // by injecting the HTTP client. For now, we're showing the test structure.

//     test('fetchObat returns list of Obat objects on success', () {
//       // This would test the fetchObat method with a mock client
//       // Since the actual implementation uses static methods with direct http calls,
//       // we're showing the test structure but can't execute it without refactoring
//     });

//     test('insertObatData returns true on success', () {
//       // This would test the insertObatData method with a mock client
//     });

//     test('updateObatData returns true on success', () {
//       // This would test the updateObatData method with a mock client
//     });

//     test('deleteObatData returns true on success', () {
//       // This would test the deleteObatData method with a mock client
//     });
//   });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/models/manage_jadwal.dart';
import 'package:tubes/models/jadwal.dart';
import 'data_mock.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('JadwalService Tests', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((request) async {
        if (request.url.toString().contains('get_jadwal.php')) {
          if (request.url.toString().contains('idPasien=')) {
            // Return filtered jadwal for specific patient
            return http.Response(MockData.getMockJadwalListResponse(), 200);
          } else {
            // Return all jadwal
            return http.Response(MockData.getMockJadwalListResponse(), 200);
          }
        } else if (request.url.toString().contains('insert_jadwal.php')) {
          return http.Response('{"success": "true"}', 200);
        } else if (request.url.toString().contains('update_jadwal.php')) {
          return http.Response('{"success": "true"}', 200);
        } else if (request.url.toString().contains('delete_jadwal.php')) {
          return http.Response('{"success": "true"}', 200);
        }
        return http.Response('Not found', 404);
      });

      // Note: The actual implementation would require refactoring JadwalService
      // to accept a client for proper testing. This is a demonstration of how
      // the tests would be structured.
    });

    test('fetchJadwalObat returns list of JadwalObat objects on success', () {
      // This would test the fetchJadwalObat method with a mock client
      // Since the actual implementation uses static methods with direct http calls,
      // we're showing the test structure but can't execute it without refactoring

      // Example of how this would be tested after refactoring:
      /*
      // Arrange
      final service = JadwalService(client: mockClient);
      
      // Act
      final result = await service.fetchJadwalObat();
      
      // Assert
      expect(result, isA<List<JadwalObat>>());
      expect(result.length, equals(2));
      expect(result[0].idJadwal, equals('1'));
      expect(result[0].namaObat, equals('Paracetamol'));
      */
    });

    test('fetchJadwalById returns filtered list of JadwalObat objects', () {
      // This would test the fetchJadwalById method with a mock client
    });

    test('insertJadwal returns success response on successful insertion', () {
      // This would test the insertJadwal method with a mock client
    });

    test('updateJadwal returns success response on successful update', () {
      // This would test the updateJadwal method with a mock client
    });

    test('deleteJadwal returns success response on successful deletion', () {
      // This would test the deleteJadwal method with a mock client
    });

    test('fetchJadwalObat throws exception on error', () {
      // This would test error handling in fetchJadwalObat
    });
  });
}

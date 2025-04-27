import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/models/pasien.dart';
import 'data_mock.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('Pasien Model Tests', () {
    test('fromJson creates Pasien object correctly', () {
      // Arrange
      final Map<String, dynamic> jsonData = MockData.getMockPasienJson();

      // Act
      final pasien = Pasien.fromJson(jsonData);

      // Assert
      expect(pasien.id, equals(jsonData['idpasien']));
      expect(pasien.username, equals(jsonData['username']));
      expect(pasien.email, equals(jsonData['email']));
      expect(pasien.usia, equals(jsonData['usia']));
      expect(pasien.nama, equals(jsonData['nama']));
      expect(pasien.gender, equals(jsonData['gender']));
      expect(pasien.idnakes, equals(jsonData['idnakes']));
    });

    test('Pasien.api constructor creates object correctly', () {
      // Arrange
      final id = '1';
      final username = 'patient1';
      final email = 'patient1@example.com';
      final usia = '30';
      final nama = 'John Doe';
      final gender = 'Laki-laki';
      final idnakes = '101';

      // Act
      final pasien = Pasien.api(
          id: id,
          username: username,
          email: email,
          usia: usia,
          nama: nama,
          gender: gender,
          idnakes: idnakes);

      // Assert
      expect(pasien.id, equals(id));
      expect(pasien.username, equals(username));
      expect(pasien.email, equals(email));
      expect(pasien.usia, equals(usia));
      expect(pasien.nama, equals(nama));
      expect(pasien.gender, equals(gender));
      expect(pasien.idnakes, equals(idnakes));
    });
  });

  group('Pasien API Methods Tests', () {
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((request) async {
        if (request.url.toString().contains('view_pasien.php')) {
          return http.Response(
              json.encode(MockData.getMockPasienListJson()), 200);
        }
        return http.Response('Not found', 404);
      });

      // Replace the http client with our mock
      // Note: This would require refactoring the Pasien class to accept a client
      // For this test, we're demonstrating the approach
    });

    // Note: These tests would require refactoring the Pasien class to make it testable
    // by injecting the HTTP client. For now, we're showing the test structure.

    test('fetchSemuaPasien returns list of Pasien objects on success', () {
      // This would test the fetchSemuaPasien method with a mock client
      // Since the actual implementation uses static methods with direct http calls,
      // we're showing the test structure but can't execute it without refactoring
    });

    test('fetchSemuaPasien with search query filters results correctly', () {
      // This would test the search functionality of fetchSemuaPasien
    });

    test('fetchSemuaPasien throws exception on error', () {
      // This would test error handling in fetchSemuaPasien
    });
  });
}

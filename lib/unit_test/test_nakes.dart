import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/models/nakes.dart';

void main() {
  group('Nakes Model Tests', () {
    test('Nakes constructor creates object correctly', () {
      // Arrange
      final nakes = Nakes();
      nakes.id = '101';
      nakes.username = 'doctor1';
      nakes.namaLengkap = 'Dr. John Smith';
      nakes.password = 'password123';
      nakes.email = 'doctor1@example.com';
      nakes.nomorSTR = 'STR12345';

      // Assert
      expect(nakes.id, equals('101'));
      expect(nakes.username, equals('doctor1'));
      expect(nakes.namaLengkap, equals('Dr. John Smith'));
      expect(nakes.password, equals('password123'));
      expect(nakes.email, equals('doctor1@example.com'));
      expect(nakes.nomorSTR, equals('STR12345'));
      expect(nakes.PasienDirawat, isNull);
    });

    test('Nakes can store list of patients', () {
      // Arrange
      final nakes = Nakes();
      nakes.id = '101';
      nakes.username = 'doctor1';

      // Create a mock list of patients
      nakes.PasienDirawat = [];

      // Assert
      expect(nakes.PasienDirawat, isNotNull);
      expect(nakes.PasienDirawat, isEmpty);
    });
  });
}

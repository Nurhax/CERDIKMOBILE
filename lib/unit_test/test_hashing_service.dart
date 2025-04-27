import 'package:flutter_test/flutter_test.dart';
import 'package:tubes/Security/hashing_service.dart';

void main() {
  group('Hashing Service Tests', () {
    test('hashPassword returns a non-empty string', () {
      // Arrange
      final password = 'password123';

      // Act
      final hashedPassword = HashingService.hashPassword(password);

      // Assert
      expect(hashedPassword, isNotEmpty);
      expect(hashedPassword, isA<String>());
      expect(hashedPassword,
          isNot(equals(password))); // Should not return original password
    });

    test('hashPassword returns different hashes for different inputs', () {
      // Arrange
      final password1 = 'password123';
      final password2 = 'password456';

      // Act
      final hashedPassword1 = HashingService.hashPassword(password1);
      final hashedPassword2 = HashingService.hashPassword(password2);

      // Assert
      expect(hashedPassword1, isNot(equals(hashedPassword2)));
    });

    test('hashPassword returns consistent hash for same input', () {
      // Arrange
      final password = 'password123';

      // Act
      final hashedPassword1 = HashingService.hashPassword(password);
      final hashedPassword2 = HashingService.hashPassword(password);

      // Assert
      expect(hashedPassword1, equals(hashedPassword2));
    });
  });
}

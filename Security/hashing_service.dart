import 'package:bcrypt/bcrypt.dart';

class HashingService {
  // Hash password securely using bcrypt
  static String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  // Verify password
  static bool verifyPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }
}

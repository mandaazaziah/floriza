// lib/services/auth_service.dart
import '../models/user.dart';

class AuthService {
  // Login tanpa cek database/user list
  User? login(String email, String password) {
    // ✅ apapun email & password dianggap berhasil
    return User(
      username: "Guest", 
      email: email, 
      password: password,
    );
  }

  // Register langsung true (tidak dipakai)
  bool register(User user) {
    return true;
  }

  // Reset password langsung true
  bool resetPassword(String email, String newPassword) {
    return true;
  }
}

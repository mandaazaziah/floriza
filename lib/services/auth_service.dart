import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  get phone => null;

  // register 
  Future<bool> register(String name, String email, String password,) async {
    final prefs = await SharedPreferences.getInstance();

    // simpan data
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setBool('isLoggedIn', true);
  
    return true;
  }

  // login
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    final savedPassword = prefs.getString('password');

    if (savedEmail == email && savedPassword == password) {
      await prefs.setBool('isLoggedIn', true);
      return true;
    }
    return false;
  }

  // logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  /// Reset password
  Future<bool> resetPassword(String email, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');

    if (savedEmail == email) {
      await prefs.setString('password', newPassword);
      return true;
    }
    return false;
  }

  /// Cek apakah user sedang login
   Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) return null;

    final name = prefs.getString('name');
    final email = prefs.getString('email');
    final password = prefs.getString('password');

    if (name != null && email != null && password != null) {
      return User(name: name, email: email, password: password);
    }
    return null;
  }

  /// Update profil (nama dan password)
  Future<void> updateProfile(String newName, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', newName);
    await prefs.setString('password', newPassword);
    
  }
}


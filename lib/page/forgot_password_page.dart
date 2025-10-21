import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  final bool fromProfile; 
  const ForgotPasswordPage({super.key, this.fromProfile = false});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  final AuthService _authService = AuthService();

  bool _showNewPassword = false;
  bool _showConfirmPassword = false;

  void _onResetPassword() {
    if (_formKey.currentState!.validate()) {
      bool success =
          _authService.resetPassword(_emailCtrl.text, _newPasswordCtrl.text) as bool;
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password berhasil direset! Silakan login."),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email tidak terdaftar."),
            backgroundColor: Color(0xFFD32F2F),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fromProfile ? "Ubah Password" : "Reset Password"),
        backgroundColor: const Color(0xFFD8B4FE),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return "Email wajib diisi";
                    final email = v.trim().toLowerCase();
                    final emailRegex = RegExp(r'^[\w\.\+\-]+@gmail\.com$');
                    if (!emailRegex.hasMatch(email)) {
                      return "Gunakan alamat Gmail yang valid (akhiran @gmail.com)";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _newPasswordCtrl,
                  obscureText: !_showNewPassword,
                  decoration: InputDecoration(
                    labelText: "Password Baru",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_showNewPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _showNewPassword = !_showNewPassword),
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.length < 6) ? "Minimal 6 karakter" : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmPasswordCtrl,
                  obscureText: !_showConfirmPassword,
                  decoration: InputDecoration(
                    labelText: "Konfirmasi Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => setState(() =>
                          _showConfirmPassword = !_showConfirmPassword),
                    ),
                  ),
                  validator: (v) =>
                      v != _newPasswordCtrl.text ? "Password tidak cocok" : null,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFD8B4FE),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    onPressed: _onResetPassword,
                    child: Text(widget.fromProfile ? "Simpan Perubahan" : "Reset Password"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

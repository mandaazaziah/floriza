import 'package:flutter/material.dart';

class CustomBuketPage extends StatelessWidget {
  const CustomBuketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Buket"),
        backgroundColor: const Color(0xFF6F4E37),
      ),
      body: const Center(
        child: Text(
          "Halaman Custom Buket\n(kamu bisa tambahkan form / pilihan bunga di sini)",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DekorasiPage extends StatelessWidget {
  const DekorasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dekorasi"),
        backgroundColor: const Color(0xFF6F4E37),
      ),
      body: const Center(
        child: Text(
          "Halaman Dekorasi\n(isi detail layanan dekorasi di sini)",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

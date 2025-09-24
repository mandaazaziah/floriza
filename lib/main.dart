import 'package:flutter/material.dart';
import 'page/splash_screen.dart';
import 'page/login_page.dart';
import 'page/register_page.dart';
import 'page/home_page.dart' as floriza;

void main() {
  runApp(const FlorizaApp());
}

class FlorizaApp extends StatelessWidget {
  const FlorizaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFFD8B4FE); // ungu pastel
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Floriza - Toko Bunga',
      theme: ThemeData(
        fontFamily: "Poppins",
        appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white, // semua AppBar putih
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black), // ikon back hitam
        titleTextStyle: TextStyle(
          color: Colors.black, // semua judul AppBar hitam
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Poppins",
        ),
      ),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.w800),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF3E8FF), // ungu pastel muda
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),

      // halaman awal
      home: const SplashScreen(),

      // route sederhana
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
      },

      // route dengan argumen (misal ke HomePage)
      onGenerateRoute: (settings) {
        if (settings.name == '/home') {
          final args = settings.arguments;

          if (args is Map<String, dynamic>) {
            return MaterialPageRoute(
              builder: (context) => floriza.HomePage(
                email: args['email'] ?? '', // default aman
              ),
            );
          } else {
            return MaterialPageRoute(
              builder: (context) => const floriza.HomePage(email: ''),
            );
          }
        }
        return null;
      },
    );
  }
}

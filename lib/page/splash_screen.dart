import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _titleController;
  late AnimationController _creatorController;

  late Animation<double> _logoScale;
  late Animation<Offset> _titleSlide;
  late Animation<Offset> _creatorSlide;

  List<String> words = ["Bloom", "Your", "Moment"];
  String displayedText = "";
  int wordIndex = 0;

  @override
  void initState() {
    super.initState();

    // LOGO animasi 
    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoController.forward();

    // TITLE animasi 
    _titleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _titleSlide = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));
    _titleController.forward();

    _creatorController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _creatorSlide = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _creatorController, curve: Curves.easeOut));
    _creatorController.forward();

    // TAGLINE animasi 
    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (wordIndex < words.length) {
        setState(() {
          displayedText += (wordIndex == 0 ? "" : " ") + words[wordIndex];
        });
        wordIndex++;
      } else {
        timer.cancel();
      }
    });

    // pindah ke login
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _titleController.dispose();
    _creatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFD8B4FE), Color(0xFFE6E6FA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),

            // LOGO 
            ScaleTransition(
              scale: _logoScale,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/icons/logofloriza.png',
                  height: 270,
                  width: 270,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TITLE 
            SlideTransition(
              position: _titleSlide,
              child: const Text(
                "Floriza",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 120, 79, 130),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // TAGLINE 
            Text(
              displayedText,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Color.fromARGB(255, 183, 132, 167),
              ),
            ),

            const Spacer(flex: 3),

            const SpinKitFadingCircle(
              color: Color(0xFFB784A7),
              size: 40.0,
            ),

            const Spacer(),
            // CREATOR 
            SlideTransition(
              position: _creatorSlide,
              child: const Text(
                "Created by : Manda",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
    
 
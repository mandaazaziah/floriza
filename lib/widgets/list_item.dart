import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final double iconSize; // biar bisa atur besar ikon

  const ListItem({  // ✅ const di sini aman
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
    this.iconSize = 80, 
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // ✅ cursor tangan
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: Card(
            color: const Color(0xFFEDE7F6), // ungu pastel
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: Row(
                children: [
                  // ikon
                  Image.asset(
                    imagePath,
                    width: iconSize,
                    height: iconSize,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 30),

                  // teks
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // panah kanan
                  const Icon(Icons.chevron_right, color: Colors.black),
                ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}

 
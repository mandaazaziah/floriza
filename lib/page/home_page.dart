import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String email;

  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER =================
            Stack(
              children: [
                Container(
                  height: 230,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/header.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 230,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Selamat Datang",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        email,
                        style:
                            const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Temukan bunga impian Anda hari ini",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ================= KATEGORI PRODUK =================
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  "Kategori Produk",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6F4E37),
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 48),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 4,
              children: [
                _buildCategoryCard(
                  "Fresh Flower",
                  "assets/icons/iconbunga.png",
                  const Color(0xFFFDF6EC),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FreshFlowerPage(), // ganti sesuai halamanmu
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  "Tanaman Hias",
                  "assets/icons/iconbunga.png",
                  const Color(0xFFEDE7F6),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TanamanHiasPage(),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  "Gift & Hampers",
                  "assets/icons/iconbunga.png",
                  const Color(0xFFEDE7F6),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GiftPage(),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  "Gift & Hampers",
                  "assets/icons/iconbunga.png",
                  const Color(0xFFEDE7F6),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GiftPage(),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  "Bunga Kering",
                  "assets/icons/iconbunga.png",
                  const Color(0xFFFDF6EC),
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BungaKeringPage(),
                      ),
                    );
                  },
                ),
              ],
            )
             

            const SizedBox(height: 50),

            // ================= LAYANAN =================
            Container(
              width: double.infinity,
              color: const Color(0xFFF5EFE6),
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Layanan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6F4E37),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildServiceCard("Custom Buket", "assets/icons/bouquet.png"),
                  _buildServiceCard("Dekorasi", "assets/icons/decor.png"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    String iconPath,
    Color bgColor,
    VoidCallback onTap, // ⬅️ tambah parameter aksi
  ) {
    return InkWell(
      onTap: onTap, // ⬅️ fungsi dipanggil saat ditekan
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: 70,
                width: 70,
              ),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  // ================= WIDGET LAYANAN (pakai gambar) =================
  Widget _buildServiceCard(String title, String imagePath) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                width: 22,
                height: 22,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 16, color: Colors.black45), // tanda >
        ],
      ),
    );
  }
}

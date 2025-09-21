import 'package:floriza/models/flower.dart';
import 'package:floriza/models/flower_data.dart';
import 'package:floriza/models/flower_type.dart';
import 'package:floriza/models/service_data.dart';
import 'package:flutter/material.dart';
import '../models/flower.dart';
import '../models/flower_data.dart';
import '../models/service.dart';
import '../models/service_data.dart';

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
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Temukan bunga impian Anda hari ini",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
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
                    final freshList = flowerList
                        .where((f) => f is! Plant && f is! DriedFlower)
                        .toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductListPage(title: "Fresh Flower", products: freshList),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  "Tanaman Hias",
                  "assets/icons/iconbunga.png",
                  const Color(0xFFEDE7F6),
                  () {
                    final plantList =
                        flowerList.where((f) => f is Plant).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductListPage(title: "Tanaman Hias", products: plantList),
                      ),
                    );
                  },
                ),
                _buildCategoryCard(
                  "Bunga Kering",
                  "assets/icons/iconbunga.png",
                  const Color(0xFFFDF6EC),
                  () {
                    final driedList =
                        flowerList.where((f) => f is DriedFlower).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductListPage(title: "Bunga Kering", products: driedList),
                      ),
                    );
                  },
                ),
              ],
            ),

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
                  ...serviceList.map((service) {
                    return _buildServiceCard(service.title, service.iconPath);
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= KATEGORI =================
  Widget _buildCategoryCard(
    String title,
    String iconPath,
    Color bgColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
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
              Image.asset(iconPath, height: 70, width: 70),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  // ================= LAYANAN =================
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
              Image.asset(imagePath, width: 22, height: 22),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios,
              size: 16, color: Colors.black45),
        ],
      ),
    );
  }
}

// ================= HALAMAN PRODUK PER KATEGORI =================
class ProductListPage extends StatelessWidget {
  final String title;
  final List<Flower> products;

  const ProductListPage({super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF6F4E37),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final flower = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(flower.imageUrl, width: 50, height: 50),
              title: Text(flower.name),
              subtitle: Text("Rp ${flower.price.toStringAsFixed(0)}"),
              onTap: () {
                // TODO: kalau mau detail produk, bisa bikin halaman detail
              },
            ),
          );
        },
      ),
    );
  }
}

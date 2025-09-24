import 'package:floriza/models/flower.dart';
import 'package:flutter/material.dart';
import '../models/flower_data.dart';
import '../models/flower_type.dart';
import '../models/service_data.dart';
import '../page/product_list_page.dart';
import '../widgets/list_item.dart';
import 'package:floriza/page/custom_buket_page.dart';
import 'package:floriza/page/dekorasi_page.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({super.key, required this.email});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // definisikan halaman di sini agar context sudah siap
    final List<Widget> pages = [
      _buildHomeContent(context),
      ProductListPage(
        title: "Semua Produk",
        products: flowerList,
        useGrid: true,
        showSearch: true,
      ),
      const Center(child: Text("Profil Saya")),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF6F4E37),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Homepage",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist),
            label: "Produk",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }

  // ✅ build home content
  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= HEADER =================
          Stack(
            children: [
              Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/gambartoko.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 250,
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
                      widget.email,
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
          const SizedBox(height: 30),

          // ================= PROMO CARD =================
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildPromoCard(
                    context,
                    icon: Icons.local_offer,
                    text: "Diskon 20% Custom Buket",
                  ),
                  _buildPromoCard(
                    context,
                    icon: Icons.card_giftcard,
                    text: "Gratis Kartu Ucapan",
                  ),
                  _buildPromoCard(
                    context,
                    icon: Icons.star,
                    text: "Diskon Member Baru",
                  ),
                ],
              ),
            ),
          ),

          // ================= KATEGORI PRODUK =================
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                "Kategori Produk",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6F4E37),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ListItem(
                  title: "Fresh Flower",
                  imagePath: "assets/icons/iconbunga.png",
                  iconSize: 80,
                  onTap: () {
                    final freshList = flowerList
                        .where((f) => f is! Plant && f is! DriedFlower)
                        .toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductListPage(
                          title: "Fresh Flower",
                          products: freshList,
                          useGrid: false,
                          showSearch: false,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),
                ListItem(
                  title: "Tanaman Hias",
                  imagePath: "assets/icons/iconbunga.png",
                  iconSize: 80,
                  onTap: () {
                    final plantList =
                        flowerList.where((f) => f is Plant).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductListPage(
                          title: "Tanaman Hias",
                          products: plantList,
                          useGrid: false,
                          showSearch: false, 
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),
                ListItem(
                  title: "Bunga Kering",
                  imagePath: "assets/icons/iconbunga.png",
                  iconSize: 80,
                  onTap: () {
                    final driedList =
                        flowerList.where((f) => f is DriedFlower).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductListPage(
                          title: "Bunga Kering",
                          products: driedList,
                          useGrid: false,
                          showSearch: false, 
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ================= LAYANAN =================
          Container(
            width: double.infinity,
            color: const Color(0xFFFFFFFF),
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
                const SizedBox(height: 12),
                Column(
                  children: serviceList.map((service) {
                    return ListItem(
                      title: service.title,
                      imagePath: service.iconPath,
                      onTap: () {
                        if (service.title == "Custom Buket") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomBuketPage()),
                          );
                        } else if (service.title == "Dekorasi") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DekorasiPage()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${service.title} tapped')),
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= PROMO CARD =================
Widget _buildPromoCard(
  BuildContext context, {
  required IconData icon,
  required String text,
  Color? color,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  double cardWidth = screenWidth > 800
      ? 220
      : screenWidth > 500
          ? 180
          : 140;

  return SizedBox(
    width: cardWidth,
    child: Container(
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFFDF6EC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color.fromARGB(135, 75, 33, 33), size: 22),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Color(0xFF6F4E37),
            ),
          ),
        ],
      ),
    ),
  );
}

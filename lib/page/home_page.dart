import 'package:floriza/page/service_page.dart' hide CustomBuketPage, DekorasiPage;
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

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _buildHomeContent(), // isi homepage
      ProductListPage(
        title: "Semua Produk",
        products: flowerList,
        useGrid: true, // ✅ taruh di sini
      ),
      const Center(child: Text("Profil Saya")),
    ];
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
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
                    image: AssetImage("assets/images/header.jpg"),
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
                      widget.email, // ✅ pakai widget.email
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

          // ----- tampilkan kategori sebagai list card -----
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                ListItem(
                  title: "Fresh Flower",
                  imagePath: "assets/icons/iconbunga.png",
                  onTap: () {
                    final freshList =
                        flowerList.where((f) => f is! Plant && f is! DriedFlower).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductListPage(title: "Fresh Flower", products: freshList),
                      ),
                    );
                  },
                ),
                ListItem(
                  title: "Tanaman Hias",
                  imagePath: "assets/icons/iconbunga.png",
                  onTap: () {
                    final plantList = flowerList.where((f) => f is Plant).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductListPage(title: "Tanaman Hias", products: plantList),
                      ),
                    );
                  },
                ),
                ListItem(
                  title: "Bunga Kering",
                  imagePath: "assets/icons/iconbunga.png",
                  onTap: () {
                    final driedList = flowerList.where((f) => f is DriedFlower).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductListPage(title: "Bunga Kering", products: driedList),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

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
                const SizedBox(height: 20),
                Column(
                  children: serviceList.map((service) {
                    return ListItem(
                      title: service.title,
                      imagePath: service.iconPath,
                      onTap: () {
                        if (service.title == "Custom Buket") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CustomBuketPage()),
                          );
                        } else if (service.title == "Dekorasi") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DekorasiPage()),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
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
}

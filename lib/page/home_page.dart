import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../models/flower_data.dart';
import '../models/flower_type.dart';
import '../models/service_data.dart';
import '../page/product_list_page.dart';
import '../widgets/list_item.dart';
import 'package:floriza/page/custom_buket_page.dart';
import 'package:floriza/page/dekorasi_page.dart';
import 'package:floriza/page/profile_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    final List<Widget> pages = [
      _buildHomeContent(context),
      ProductListPage(
        title: "Semua Produk",
        products: flowerList,
        useGrid: true,
        showSearch: true,
      ),
      const  ProfilePage(),
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: _selectedIndex == 0
            ? AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                elevation: 0,
                backgroundColor: Color(0xFFE6E6FA),
                title: Image.asset(
                  'assets/icons/logofloriza.png',
                  height: 170,
                ),
              )
            : null,
            
        body: pages[_selectedIndex],
        bottomNavigationBar: ConvexAppBar(
          style: TabStyle.reactCircle, 
          backgroundColor: const Color(0xFFFDFDFD),
          color: Color(0xFF6F4E37),
          activeColor: Color(0xFF6F4E37),
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.local_florist, title: 'Produk'),
            TabItem(icon: Icons.person, title: 'Profil'),
          ],
          initialActiveIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
    }

    // home content
    Widget _buildHomeContent(BuildContext context) {
      final List<Widget> sections = [
        _buildHeaderSection(),
        const SizedBox(height: 30),
        _buildPromoSection(context),
        const SizedBox(height: 30),
        _buildKategoriSection(context),
        const SizedBox(height: 30),
        _buildLayananSection(context),
        const SizedBox(height: 30),
        _buildTestimoniSection(),
      ];

      return ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) => sections[index],
      );
    }

    Widget _buildHeaderSection() {
      return Stack(
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
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.black.withOpacity(0.3),
            alignment: Alignment.center,
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
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
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
      );
    }

    Widget _buildPromoSection(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildPromoCard(context, icon: Icons.local_offer, text: "Diskon 20% Custom Buket"),
              _buildPromoCard(context, icon: Icons.card_giftcard, text: "Gratis Kartu Ucapan"),
              _buildPromoCard(context, icon: Icons.star, text: "Diskon Member Baru"),
            ],
          ),
        ),
      );
    }

    Widget _buildKategoriSection(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Kategori Produk",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6F4E37),
              ),
            ),
            const SizedBox(height: 12),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListItem(
                  title: "Fresh Flower",
                  imagePath: "assets/icons/iconbunga.png",
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
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildLayananSection(BuildContext context) {
      return Container(
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
                        MaterialPageRoute(builder: (context) => CustomBuketPage()),
                      );
                    } else if (service.title == "Dekorasi") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DekorasiPage()),
                      );
                    }
                  },
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    Widget _buildTestimoniSection() {
      return Container(
        width: double.infinity,
        color: const Color(0xFFFDF6EC),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Testimoni Pelanggan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6F4E37),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _TestimoniCard(
                      nama: "Aulia",
                      komentar: "Pelayanannya cepat banget! Bunganya juga fresh 💐",
                      rating: 5),
                  _TestimoniCard(
                      nama: "Rizky",
                      komentar: "Dekorasi acara ulang tahunku super keren 🎉",
                      rating: 4),
                  _TestimoniCard(
                      nama: "Mira",
                      komentar: "Custom buketnya lucu banget 🌸",
                      rating: 5),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

class _TestimoniCard extends StatelessWidget {
  final String nama;
  final String komentar;
  final int rating;

  const _TestimoniCard({
    required this.nama,
    required this.komentar,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingBarIndicator(
            rating: rating.toDouble(),
            itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
            itemCount: 5,
            itemSize: 20,
          ),
          const SizedBox(height: 8),
          Text(
            '"$komentar"',
            style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text("- $nama", style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

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
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF6F4E37)),
          ),
        ],
      ),
    ),
  );
}
import 'package:flutter/material.dart';

class CustomBuketPage extends StatefulWidget {
  const CustomBuketPage({super.key});

  @override
  State<CustomBuketPage> createState() => _CustomBuketPageState();
}

class _CustomBuketPageState extends State<CustomBuketPage> {
  String? selectedFlower;
  String? selectedColor;
  final TextEditingController _stemsController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  List<String> flowerOptions = ["Mawar", "Tulip", "Lily", "Dahlia", "Aster", "Krisan"];
  List<String> colorOptions = ["Merah", "Pink", "Kuning", "Oranye", "Putih", "Ungu", "Campur"];

  // aksesoris
  bool includeRibbon = false;
  bool includeCard = false;
  bool includeDoll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD), // cream soft bg
      appBar: AppBar(
        title: const Text("Custom Buket"),
        backgroundColor: const Color(0xFFE6E6FA), // coklat kopi
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Pilih jenis bunga =====
            _buildSectionTitle("Pilih jenis bunga"),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedFlower,
              hint: const Text("Pilih bunga"),
              items: flowerOptions.map((f) {
                return DropdownMenuItem(
                  value: f,
                  child: Text(f),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedFlower = val;
                });
              },
            ),
            const SizedBox(height: 20),

            // ===== Jumlah tangkai =====
            _buildSectionTitle("Jumlah tangkai"),
            TextField(
              controller: _stemsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan jumlah tangkai",
              ),
            ),
            const SizedBox(height: 20),

            // ===== Warna bunga =====
            _buildSectionTitle("Warna bunga"),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedColor,
              hint: const Text("Pilih warna"),
              items: colorOptions.map((c) {
                return DropdownMenuItem(
                  value: c,
                  child: Text(c),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedColor = val;
                });
              },
            ),
            const SizedBox(height: 20),

            // ===== Aksesoris tambahan =====
            _buildSectionTitle("Aksesoris tambahan"),
            CheckboxListTile(
              title: const Text("Pita"),
              value: includeRibbon,
              onChanged: (val) {
                setState(() => includeRibbon = val ?? false);
              },
            ),
            CheckboxListTile(
              title: const Text("Kartu Ucapan"),
              value: includeCard,
              onChanged: (val) {
                setState(() => includeCard = val ?? false);
              },
            ),
            CheckboxListTile(
              title: const Text("Boneka Mini"),
              value: includeDoll,
              onChanged: (val) {
                setState(() => includeDoll = val ?? false);
              },
            ),
            const SizedBox(height: 20),

            // ===== Pesan khusus =====
            _buildSectionTitle("Pesan khusus"),
            TextField(
              controller: _messageController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tuliskan keinginanmu di sini...",
              ),
            ),
            const SizedBox(height: 20),

            // ===== Preview =====
            _buildSectionTitle("Preview Pesanan"),
            SizedBox(
            width: double.infinity, // ✅ biar full width kayak Pesan khusus
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("🌸 Bunga : ${selectedFlower ?? "-"}"),
                    Text("🌿 Jumlah : ${_stemsController.text.isEmpty ? "-" : _stemsController.text} tangkai"),
                    Text("🎨 Warna : ${selectedColor ?? "-"}"),
                    Text("✨ Aksesoris : ${_getAccessoriesText()}"),
                    Text("💌 Pesan : ${_messageController.text.isEmpty ? "-" : _messageController.text}"),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

            // ===== Tombol Pesan =====
            SizedBox(
              width: double.infinity,
              child: MouseRegion(
                cursor: SystemMouseCursors.click, 
                child: ElevatedButton(
                  onPressed: () {
                    if (selectedFlower == null ||
                        selectedColor == null ||
                        _stemsController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Lengkapi pilihan buket dulu ya!")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Pesanan dibuat:\n$selectedFlower - ${_stemsController.text} tangkai - $selectedColor",
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE6E6FA),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    "Pesan Sekarang",
                    style: TextStyle(
                      color: Colors.black,       // ✅ warna teks hitam
                      fontWeight: FontWeight.bold, // ✅ biar bold
                    ),
                  ),
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }

  // Widget judul section
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  // Utility aksesoris
  String _getAccessoriesText() {
    List<String> items = [];
    if (includeRibbon) items.add("Pita");
    if (includeCard) items.add("Kartu Ucapan");
    if (includeDoll) items.add("Boneka Mini");
    return items.isEmpty ? "-" : items.join(", ");
  }
}

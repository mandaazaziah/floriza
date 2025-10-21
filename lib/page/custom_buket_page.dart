import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dtp;

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List<String> flowerOptions = ["Mawar", "Tulip", "Lily", "Dahlia", "Aster", "Krisan"];
  List<String> colorOptions = ["Merah", "Pink", "Kuning", "Oranye", "Putih", "Ungu", "Campur"];

  bool includeRibbon = false;
  bool includeCard = false;
  bool includeDoll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD), 
      appBar: AppBar(
        title: const Text("Custom Buket"),
        backgroundColor: const Color(0xFFE6E6FA), 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // nama pemesan
          _buildSectionTitle("Nama Pemesan"),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Masukkan nama kamu",
            ),
          ),
          const SizedBox(height: 20),

          // nomor hp
          _buildSectionTitle("Nomor HP"),
          TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Masukkan nomor HP aktif",
            ),
          ),
          const SizedBox(height: 20),

          // tanggal pemesanan
          _buildSectionTitle("Tanggal Pemesanan"),
          TextField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: "Pilih tanggal pemesanan",
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: _pickDate,
              ),
            ),
            onTap: _pickDate,
          ),
          const SizedBox(height: 20),

            // pilih jenis bunga
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

            // jumlah tangkai
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

            // warna bunga
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

            // aksesoris tambahan
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

            // pesan khusus 
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

            // preview 
            _buildSectionTitle("Preview Pesanan"),
            SizedBox(
            width: double.infinity, 
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
                    Text("Bunga : ${selectedFlower ?? "-"}"),
                    Text("Jumlah : ${_stemsController.text.isEmpty ? "-" : _stemsController.text} tangkai"),
                    Text("Warna : ${selectedColor ?? "-"}"),
                    Text("Aksesoris : ${_getAccessoriesText()}"),
                    Text("Pesan : ${_messageController.text.isEmpty ? "-" : _messageController.text}"),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
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
                      _showConfirmDialog(); 
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F4E37),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                  ),
                  child: const Text(
                    "Pesan Sekarang",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  // aksesoris
  String _getAccessoriesText() {
    List<String> items = [];
    if (includeRibbon) items.add("Pita");
    if (includeCard) items.add("Kartu Ucapan");
    if (includeDoll) items.add("Boneka Mini");
    return items.isEmpty ? "-" : items.join(", ");
  }

  void _pickDate() {
    dtp.DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.now(),
      maxTime: DateTime(2030, 12, 31),
      locale: dtp.LocaleType.id,
      theme: const dtp.DatePickerTheme(
        headerColor: Color(0xFFE6E6FA),
        backgroundColor: Colors.white,
        itemStyle: TextStyle(color: Colors.black87, fontSize: 18),
        doneStyle: TextStyle(
          color: Color(0xFF6F4E37),
          fontWeight: FontWeight.bold,
        ),
      ),
      onConfirm: (date) {
        setState(() {
          _dateController.text = "${date.day}-${date.month}-${date.year}";
        });
      },
      currentTime: DateTime.now(),
    );
  }

  void _showConfirmDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text("Konfirmasi Pesanan"),
        content: Text(
          "Apakah kamu yakin ingin memesan buket ini?\n\n"
          "• Nama : ${_nameController.text}\n"
          "• No HP : ${_phoneController.text}\n"
          "• Tanggal : ${_dateController.text}\n"
          "• Bunga : ${selectedFlower ?? '-'}\n"
          "• Jumlah : ${_stemsController.text} tangkai\n"
          "• Warna : ${selectedColor ?? '-'}\n"
          "• Aksesoris : ${_getAccessoriesText()}",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6F4E37),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(context);

              final prefs = await SharedPreferences.getInstance();
              final orders = prefs.getStringList('orders') ?? [];

              final now = DateTime.now();
              final formattedDate =
                  "${now.day}-${now.month}-${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}";

              final newOrder =
                  "Custom Buket | ${selectedFlower ?? '-'} | ${_stemsController.text.isEmpty ? '-' : _stemsController.text} tangkai | Warna: ${selectedColor ?? '-'} | ${_getAccessoriesText()} | Nama: ${_nameController.text} | No HP: ${_phoneController.text} | Tanggal: ${_dateController.text}";

              orders.add(newOrder);
              await prefs.setStringList('orders', orders);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Pesanan Custom Buket berhasil dikonfirmasi dan disimpan!"),
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(20),
                ),
              );
            },
            child: const Text("Ya, Pesan Sekarang"),
          ),
        ],
      );
    },
  );
}
}

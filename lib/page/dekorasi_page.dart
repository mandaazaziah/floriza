import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dtp;

class DekorasiPage extends StatelessWidget {
  DekorasiPage({Key? key}) : super(key: key);

  final List<Map<String, String>> paketDekorasi = const [
    {
      "nama": "Dekorasi Ulang Tahun",
      "deskripsi": "Dekorasi ulang tahun dengan balon warna-warni, backdrop cantik, "
        "meja kue yang dihias rapi, serta tambahan ornamen sesuai tema pilihan. "
        "Cocok untuk pesta anak-anak maupun perayaan dewasa agar suasana lebih meriah dan berkesan.",
      "harga": "Rp 500.000"
    },
    {
      "nama": "Dekorasi Pernikahan",
      "deskripsi": "Paket dekorasi pernikahan mewah dengan rangkaian bunga segar, "
        "pelaminan elegan, pencahayaan romantis, serta sentuhan detail artistik "
        "pada meja tamu dan jalan pengantin. Dirancang untuk menciptakan suasana sakral, indah, dan tak terlupakan.",
      "harga": "Rp 5.000.000"
    },
    {
      "nama": "Dekorasi Event Kantor",
      "deskripsi": "Dekorasi khusus acara kantor dengan penataan tanaman hias kecil, "
        "rangkaian bunga segar, backdrop profesional, serta penataan meja kerja yang rapi. "
        "Memberikan kesan formal namun tetap hangat, ideal untuk seminar, rapat penting, atau gathering perusahaan.",
      "harga": "Rp 300.000"
    },
  ];

  Future<Map<String, String>> _getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName') ?? ''; 
    final phone = prefs.getString('userPhone') ?? '';
    return {'name': name, 'phone': phone};
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paket Dekorasi"),
        backgroundColor: const Color(0xFFE6E6FA),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: paketDekorasi.length,
        itemBuilder: (context, index) {
          final paket = paketDekorasi[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paket["nama"]!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    paket["deskripsi"]!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Harga: ${paket["harga"]!}",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F4E37),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        final profile = await _getUserProfile();

                        final nameController =
                            TextEditingController(text: profile['name']);
                        final phoneController =
                            TextEditingController(text: profile['phone']);
                        final dateController = TextEditingController();
                        final noteController = TextEditingController();

                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (sheetContext) {
                            return StatefulBuilder(
                              builder: (context, setSheetState) {
                                Future<void> pickDate() async {
                                  dtp.DatePicker.showDatePicker(
                                    sheetContext,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime(2030, 12, 31),
                                    locale: dtp.LocaleType.id,
                                    theme: const dtp.DatePickerTheme(
                                      headerColor: Color(0xFFE6E6FA),
                                      backgroundColor: Colors.white,
                                      itemStyle: TextStyle(
                                          color: Colors.black87, fontSize: 18),
                                      doneStyle: TextStyle(
                                          color: Color(0xFF6F4E37),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onConfirm: (date) {
                                      setSheetState(() {
                                        dateController.text =
                                            "${date.day}-${date.month}-${date.year}";
                                      });
                                    },
                                    currentTime: DateTime.now(),
                                  );
                                }

                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(sheetContext)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFDEEFF),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 50,
                                              height: 4,
                                              margin: const EdgeInsets.only(
                                                  bottom: 12),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[400],
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              "Form Pemesanan Dekorasi",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(height: 12),

                                          // Nama Pemesan
                                          TextField(
                                            controller: nameController,
                                            decoration: const InputDecoration(
                                              labelText: "Nama Pemesan",
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          // Nomor HP
                                          TextField(
                                            controller: phoneController,
                                            decoration: const InputDecoration(
                                              labelText: "Nomor HP",
                                              border: OutlineInputBorder(),
                                            ),
                                            keyboardType: TextInputType.phone,
                                          ),
                                          const SizedBox(height: 10),

                                          // Tanggal Booking
                                          TextField(
                                            controller: dateController,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              labelText: "Tanggal Booking",
                                              border:
                                                  const OutlineInputBorder(),
                                              suffixIcon: IconButton(
                                                icon: const Icon(
                                                    Icons.calendar_today),
                                                onPressed: pickDate,
                                              ),
                                            ),
                                            onTap: pickDate,
                                          ),
                                          const SizedBox(height: 10),

                                          // Catatan (opsional)
                                          TextField(
                                            controller: noteController,
                                            decoration: const InputDecoration(
                                              labelText: "Catatan (opsional)",
                                              border: OutlineInputBorder(),
                                            ),
                                            maxLines: 2,
                                          ),
                                          const SizedBox(height: 18),

                                          // Tombol Konfirmasi
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF6F4E37),
                                                foregroundColor: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14),
                                              ),
                                              onPressed: () async {
                                                final prefs = await SharedPreferences.getInstance();
                                                final orders = prefs.getStringList('orders') ?? [];

                                                final newOrder =
                                                    "Dekorasi | ${paket["nama"]} | Tanggal: ${dateController.text} | Catatan: ${noteController.text.isEmpty ? '-' : noteController.text} | Nama: ${nameController.text} | No HP: ${phoneController.text}";

                                                orders.add(newOrder);
                                                await prefs.setStringList('orders', orders);

                                                if (sheetContext.mounted) Navigator.pop(sheetContext);

                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Pesanan berhasil dikirim'),
                                                    behavior: SnackBarBehavior.floating,
                                                    margin: EdgeInsets.all(20),
                                                  ),
                                                );
                                              },

                                              child: const Text(
                                                  "Konfirmasi Pesanan"),
                                            ),
                                          ),
                                          const SizedBox(height: 10),

                                          // Tombol Batal
                                          SizedBox(
                                            width: double.infinity,
                                            child: OutlinedButton(
                                              style:
                                                  OutlinedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                              ),
                                              onPressed: () {
                                                if (sheetContext.mounted)
                                                  Navigator.pop(sheetContext);
                                              },
                                              child: const Text(
                                                "Batal",
                                                style: TextStyle(
                                                    color: Color(0xFFD32F2F)),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: const Text("Pesan Sekarang"),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
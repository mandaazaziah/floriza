import 'package:flutter/material.dart';

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
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    paket["deskripsi"]!,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Harga : ${paket["harga"]!}",
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
                        backgroundColor: const Color(0xFFE6E6FA),
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Anda memilih ${paket["nama"]!}",
                            ),
                          ),
                        );
                      },
                      child: const Text("Konfirmasi"),
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

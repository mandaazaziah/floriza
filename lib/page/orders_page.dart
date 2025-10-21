import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<String> orders = [];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      orders = prefs.getStringList('orders') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
        backgroundColor: const Color(0xFFE6E6FA),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text(
                'Belum ada pesanan',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];

                // ambil jenis pesanan dari awal teks (sebelum tanda '|')
                final type = order.split('|').first.trim();

                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 🟤 ikon otomatis berdasarkan jenis pesanan
                        Icon(
                          type.contains('Dekorasi')
                              ? Icons.celebration       // 🎉 dekorasi
                              : type.contains('Custom')
                                  ? Icons.handyman      // 🧺 custom buket
                                  : Icons.local_florist, // 🌸 produk bunga biasa
                          color: const Color(0xFF6F4E37),
                          size: 28,
                        ),
                        const SizedBox(width: 12),

                        // 🟤 isi teks pesanan
                        Expanded(
                          child: Text(
                            order,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.4,
                            ),
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

import 'package:flutter/material.dart';

class ProductModelPage extends StatelessWidget {
  const ProductModelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Model"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.local_florist, color: Colors.green),
            title: Text("Bunga Segar"),
            subtitle: Text("Fresh Flower Collection"),
          ),
          ListTile(
            leading: Icon(Icons.spa, color: Colors.brown),
            title: Text("Bunga Kering"),
            subtitle: Text("Dried Flower Collection"),
          ),
          ListTile(
            leading: Icon(Icons.eco, color: Colors.teal),
            title: Text("Tanaman Hias"),
            subtitle: Text("Indoor & Outdoor Plants"),
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard, color: Colors.red),
            title: Text("Layanan"),
            subtitle: Text("Gift Hampers & Custom Buket"),
          ),
        ],
      ),
    );
  }
}

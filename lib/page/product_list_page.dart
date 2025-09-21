import 'package:flutter/material.dart';
import '../models/flower.dart';

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
      body: products.isEmpty
          ? const Center(child: Text("Belum ada produk"))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final flower = products[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.asset(flower.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(flower.name),
                    subtitle: Text("Rp ${flower.price.toStringAsFixed(0)}"),
                    onTap: () {
                      final tips = flower.getCareTips();
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text(flower.name),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(flower.imageUrl, width: 150, height: 120, fit: BoxFit.cover),
                              const SizedBox(height: 8),
                              Text(flower.description),
                              const SizedBox(height: 8),
                              Text("Tips: $tips"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/flower.dart';
import 'detail_page.dart'; 

class ProductListPage extends StatelessWidget {
  final String title;
  final List<Flower> products;
  final bool useGrid; 

  const ProductListPage({
    super.key,
    required this.title,
    required this.products,
    this.useGrid = false, // default tetap ListView
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF6F4E37),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: products.isEmpty
          ? const Center(child: Text("Belum ada produk"))
          : useGrid
              ? GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,      // ✅ 2 kolom
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final flower = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(product: flower),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(12)),
                                child: Image.asset(
                                  flower.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                flower.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Text(
                              "Rp ${flower.price.toStringAsFixed(0)}",
                              style: const TextStyle(color: Colors.brown),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    );
                  },
                )
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final flower = products[index];
                return Card(
                  elevation: 4, 
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  mouseCursor: SystemMouseCursors.click, // ✅ Biar kursornya jadi tangan
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: flower),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Image.asset(
                      flower.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(flower.name),
                    subtitle: Text("Rp ${flower.price.toStringAsFixed(0)}"), 
                  ),
                ),
              );
            },
          ),
    );
  }
}

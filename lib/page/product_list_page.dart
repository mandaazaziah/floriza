import 'package:flutter/material.dart';
import 'package:flutter_scroll_to_top/flutter_scroll_to_top.dart';
import '../models/flower.dart';
import 'detail_page.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final List<Flower> products;
  final bool useGrid;
  final bool showSearch; 

  const ProductListPage({
    super.key,
    required this.title,
    required this.products,
    this.useGrid = false,
    this.showSearch = true, 
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  String _query = "";
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = widget.products
        .where((flower) =>
            flower.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.useGrid, 
        leading: !widget.useGrid
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : null,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFE6E6FA),
        centerTitle: true,
      ),
      body: ScrollWrapper(
        scrollController: _scrollController,
        promptAlignment: Alignment.bottomRight,
        promptTheme: const PromptButtonTheme(
          color: Color(0xFF6F4E37),
          icon: Icon(Icons.arrow_upward, color: Colors.white),
        ),
        builder: (context, properties) {
          return Column(
            children: [
              if (widget.showSearch)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari produk...",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _query = value;
                      });
                    },
                  ),
                ),

              Expanded(
                child: ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  children: [
                    filteredProducts.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: Text(
                                "Produk tidak ditemukan",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                          )
                        : widget.useGrid
                            // Tampilan Grid 
                            ? GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(12),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.75,
                                ),
                                itemCount: filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final flower = filteredProducts[index];
                                  return _buildProductCard(context, flower);
                                },
                              )
                            // Tampilan List 
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final flower = filteredProducts[index];
                                  return _buildProductTile(context, flower);
                                },
                              ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Flower flower) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: flower),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
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
                    fontWeight: FontWeight.bold, fontSize: 14),
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
  }

  Widget _buildProductTile(BuildContext context, Flower flower) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            flower.imageUrl,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          flower.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Rp ${flower.price.toStringAsFixed(0)}",
          style: const TextStyle(color: Colors.brown),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(product: flower),
            ),
          );
        },
      ),
    );
  }
}
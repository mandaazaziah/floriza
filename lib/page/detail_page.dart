import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as dtp;
import '../models/flower.dart';
import 'package:flutter/services.dart';

class ProductDetailPage extends StatefulWidget {
  final Flower product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final qtyController = TextEditingController();
  final noteController = TextEditingController();
  final dateController = TextEditingController();

  void _showBookingSheet(BuildContext context) {
    String? errorText;

    showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return StatefulBuilder(
        builder: (context, setSheetState) {
          void pickDate() {
            dtp.DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              minTime: DateTime.now(),
              maxTime: DateTime(2100),
              theme: const dtp.DatePickerTheme(
                headerColor: Color(0xFFE6E6FA),
                backgroundColor: Colors.white,
                itemStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                doneStyle: TextStyle(color: Colors.deepPurple, fontSize: 16),
              ),
              onConfirm: (date) {
                setState(() {
                  dateController.text = "${date.day}-${date.month}-${date.year}";
                });
              },
              currentTime: DateTime.now(),
              locale: dtp.LocaleType.id,
            );
          }

          final nameController = TextEditingController();
          final phoneController = TextEditingController();

          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFDEEFF),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Form Pemesanan",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),

                    if (errorText != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          errorText!,
                          style: const TextStyle(
                            color: Color(0xFFD32F2F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Nama Pemesan",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: "Nomor HP Pemesan",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: qtyController,
                      decoration: const InputDecoration(
                        labelText: "Jumlah Produk",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: dateController,
                      readOnly: true,
                      onTap: pickDate,
                      decoration: InputDecoration(
                        labelText: "Tanggal Booking",
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: pickDate,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        labelText: "Catatan (opsional)",
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 12),

                    // Tombol kirim
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F4E37),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      onPressed: () async {
                        if (qtyController.text.isEmpty ||
                            dateController.text.isEmpty ||
                            nameController.text.isEmpty ||
                            phoneController.text.isEmpty) {
                          setSheetState(() {
                            errorText = "Semua kolom wajib diisi (kecuali catatan)!";
                          });
                          return;
                        }

                        final prefs = await SharedPreferences.getInstance();
                        final orders = prefs.getStringList('orders') ?? [];
                        orders.add(
                          "${widget.product.name}\n"
                          "Nama: ${nameController.text}\n"
                          "No HP: ${phoneController.text}\n"
                          "Jumlah: ${qtyController.text}\n"
                          "Tanggal: ${dateController.text}\n"
                          "Catatan: ${noteController.text.isEmpty ? '-' : noteController.text}\n"
                        );
                        await prefs.setStringList('orders', orders);

                        if (context.mounted) {
                          Navigator.pop(sheetContext);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Pesanan berhasil dikirim'),
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        "Kirim Pesanan",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: const Text(
                        "Batal",
                        style: TextStyle(color: Color(0xFFD32F2F)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.product.name,
          style: const TextStyle(color: Colors.black), 
        ),
        backgroundColor: const Color(0xFFE6E6FA),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8), 

            Hero(
              tag: widget.product.imageUrl,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
                child: Image.asset(
                  widget.product.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // nama & harga
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rp ${widget.product.price.toStringAsFixed(0)}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.product.description,
                    style: const TextStyle(fontSize: 15, color: Colors.black87, height: 1.4),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.product.getCareTips(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,   
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () => _showBookingSheet(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F4E37),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Pesan Sekarang',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

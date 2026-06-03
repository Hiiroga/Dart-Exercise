import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/models.dart';
import '../utils/api_service.dart';
import '../widgets/widgets.dart';

class Tutorial12Screen extends StatefulWidget {
  const Tutorial12Screen({super.key});

  @override
  State<Tutorial12Screen> createState() => _Tutorial12ScreenState();
}

class _Tutorial12ScreenState extends State<Tutorial12Screen> {
  late Future<List<Product>> _productsFuture;

  // Controller untuk input tambah produk
  final nameInput = TextEditingController();
  final priceInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService().getProducts();
  }

  @override
  void dispose() {
    nameInput.dispose();
    priceInput.dispose();
    super.dispose();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _productsFuture = ApiService().getProducts();
    });
    await _productsFuture;
  }

  // Mengirim produk baru ke API Laravel
  Future<Map<String, dynamic>> addProduct(String _name, String _price) async {
    return await ApiService().addProduct(_name, _price);
  }

  // Menampilkan dialog input produk baru
  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add New Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameInput,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: priceInput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameInput.text.trim();
                final price = priceInput.text.trim();

                // Validasi input sederhana di sisi Flutter
                if (name.length < 4) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Nama produk minimal 4 karakter'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                final priceInt = int.tryParse(price);
                if (priceInt == null || priceInt < 1000000) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harga minimal Rp 1.000.000'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                try {
                  final result = await addProduct(name, price);

                  // Refresh list produk setelah berhasil
                  setState(() {
                    _productsFuture = ApiService().getProducts();
                  });

                  // Tutup dialog
                  Navigator.of(dialogContext).pop();

                  // Kosongkan input
                  nameInput.clear();
                  priceInput.clear();

                  // Tampilkan SnackBar sukses dengan pesan dari API
                  final message =
                      result['message'] ?? 'Produk berhasil ditambah';
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  // Tampilkan SnackBar error agar aplikasi tidak crash
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Gagal menambah produk: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial 12 - Networking'),
        backgroundColor: AppColors.primaryBlue,
      ),
      // FloatingActionButton untuk membuka dialog tambah produk
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProductDialog,
        backgroundColor: AppColors.primaryBlue,
        tooltip: 'Tambah Produk',
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Gagal mengambil data product.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.marginSmall),
                    Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: AppDimensions.marginMedium),
                    ElevatedButton(
                      onPressed: _refreshProducts,
                      child: const Text('Coba lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final products = snapshot.data ?? [];
          if (products.isEmpty) {
            return const Center(child: Text('Data product kosong.'));
          }

          return RefreshIndicator(
            onRefresh: _refreshProducts,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.marginMedium,
                    vertical: AppDimensions.marginSmall,
                  ),
                  child: ProductCard(product: products[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

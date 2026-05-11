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

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService().getProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _productsFuture = ApiService().getProducts();
    });
    await _productsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial 12 - Networking'),
        backgroundColor: AppColors.primaryBlue,
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

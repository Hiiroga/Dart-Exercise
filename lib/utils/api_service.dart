import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class ApiService {
  // Ganti IP sesuai IPv4 PC yang menjalankan Laravel (cek dengan: ipconfig).
  static const String baseUrl = 'http://192.168.1.4:8000/api';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/product'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load products (${response.statusCode})');
    }

    final dynamic decodedBody = jsonDecode(response.body);
    if (decodedBody is List) {
      return decodedBody
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    if (decodedBody is Map<String, dynamic>) {
      final dynamic listData = decodedBody['list'] ?? decodedBody['data'];
      if (listData is List) {
        return listData
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    }

    throw Exception('Unexpected API response format');
  }

  // Mengirim produk baru ke API Laravel menggunakan HTTP POST
  Future<Map<String, dynamic>> addProduct(String name, String price) async {
    final res = await http.post(
      Uri.parse('$baseUrl/product'),
      body: {
        'name': name,
        'price': price,
      },
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to add product (${res.statusCode})');
    }
  }
}

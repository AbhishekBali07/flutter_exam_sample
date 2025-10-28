// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_models.dart';

class ApiService {
  static const String productUrl = "https://api.npoint.io/557f3c6cc529842333c4";
  static const String categoryUrl = "https://api.npoint.io/3216e2d45b15053f1a25";

//Product
  static Future<List<dynamic>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse(productUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData["data"];
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error fetching products: $e");
    }
  }

//Categories
  static Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await http.get(Uri.parse(categoryUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final List data = jsonData["data"];
        return data.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error fetching categories: $e");
    }
  }
}

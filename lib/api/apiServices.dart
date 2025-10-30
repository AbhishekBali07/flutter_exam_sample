import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/category_models.dart';
import '../models/cproduct_models.dart';
import '../models/main_category_models.dart';

class ApiService {
  static const String productUrl = "https://api.npoint.io/557f3c6cc529842333c4";
  static const String categoryUrl =
      "https://api.npoint.io/3216e2d45b15053f1a25";
  static const String mainCategoryUrl =
      "https://api.npoint.io/486c2783b255d1cca8d9";
  static const String productbyCategorybaseUrl =
      "https://api.npoint.io/cf74d347f4498d9fcbac";
  static const String shopnowbaseUrl =
      "https://api.npoint.io/8dbc7d092806604632d8";

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

//home page categories
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

  ///all categories

  static Future<List<MainCategoryModels>> fetchAllCategories() async {
    final url = Uri.parse("$mainCategoryUrl");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> categoryLists = data['data'];
      return categoryLists
          .map((item) => MainCategoryModels.fromJson(item))
          .toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  ////product by category

  static Future<List<CProductModel>> fetchProductsByCategory(
      String categoryName) async {
    final url = Uri.parse(productbyCategorybaseUrl);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final List allProducts = data["data"];
      final List<CProductModel> productList =
          allProducts.map((e) => CProductModel.fromJson(e)).toList();

      final List<CProductModel> filteredProducts = productList
          .where((product) =>
              product.category.toLowerCase() == categoryName.toLowerCase())
          .toList();

      return filteredProducts;
    } else {
      throw Exception("Failed to load products for $categoryName");
    }
  }

  static Future<List<CProductModel>> fetchShopNowProducts() async {
    final response = await http.get(Uri.parse(shopnowbaseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List products = data["data"];
      return products.map((json) => CProductModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }
}

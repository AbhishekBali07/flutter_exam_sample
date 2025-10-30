import 'package:flutter/material.dart';
import '../api/apiServices.dart';
import '../models/main_category_models.dart';
import 'mainCategorypage.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isLoading = true;
  List<MainCategoryModels> maincategories = [];

  @override
  void initState() {
    super.initState();
    fetchAllCategoryData();
  }

  Future<void> fetchAllCategoryData() async {
    try {
      final fetchedAllCategories = await ApiService.fetchAllCategories();
      setState(() {
        maincategories = fetchedAllCategories;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load categories: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Categories",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : maincategories.isEmpty
          ? const Center(
        child: Text(
          "No categories found",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: maincategories.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          final category = maincategories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Maincategorypage(
                    categoryName: category.name,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    category.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  Center(
                    child: Text(
                      category.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



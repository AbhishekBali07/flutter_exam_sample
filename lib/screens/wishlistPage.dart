import 'package:flutter/material.dart';

import '../models/product_models.dart';

class Wishlistpage extends StatelessWidget {
  final List<ProductModel> wishList;
  final Function(ProductModel) onWishlistToggle;

  const Wishlistpage({
    super.key,
    required this.wishList,
    required this.onWishlistToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: wishList.isEmpty
          ? const Center(
        child: Text(
          "Your wishlist is empty 💔",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: wishList.length,
        padding: const EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final product = wishList[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("₹${product.price.toStringAsFixed(0)}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => onWishlistToggle(product),
              ),
            ),
          );
        },
      ),
    );
  }
}

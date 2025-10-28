import 'package:flutter/material.dart';

import '../models/product_models.dart';

class Wishlistpage extends StatefulWidget {
  const Wishlistpage({super.key});

  @override
  State<Wishlistpage> createState() => _WishlistpageState();
}

class _WishlistpageState extends State<Wishlistpage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


/*class WishlistPage extends StatefulWidget {
  final List<ProductModel> wishList;
  const WishlistPage({super.key, required this.wishList});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Wishlist")),
      body: widget.wishList.isEmpty
          ? const Center(child: Text("No items in wishlist"))
          : ListView.builder(
        itemCount: widget.wishList.length,
        itemBuilder: (context, index) {
          final product = widget.wishList[index];
          return ListTile(
            leading: Image.network(product.image, width: 60, fit: BoxFit.cover),
            title: Text(product.name),
            subtitle: Text("₹${product.price}"),
          );
        },
      ),
    );
  }
}*/

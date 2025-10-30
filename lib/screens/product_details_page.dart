import 'package:flutter/material.dart';
import '../models/product_models.dart';
import '../globals.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final bool isWishlisted;
  final Function(ProductModel) onWishlistToggle;
  final Function(ProductModel) onAddToCart;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.isWishlisted,
    required this.onWishlistToggle,
    required this.onAddToCart,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isWishlisted = false;
  String selectedSize = "M";

  @override
  void initState() {
    super.initState();
    isWishlisted = widget.isWishlisted;
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          product.name,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.grey[100],
                width: double.infinity,
                height: 400,
                child: Image.network(
                  product.image,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "₹${product.price.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "₹3,299",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "69% OFF",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(
                          "${product.rating} (${product.reviews} reviews)",
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Size",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ["S", "M", "L", "XL"].map((size) {
                        final selected = selectedSize == size;
                        return GestureDetector(
                          onTap: () => setState(() => selectedSize = size),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color:
                                      selected ? Colors.amber : Colors.grey.shade300,
                                  width: 2,
                                ),
                                color: selected
                                    ? Colors.pink.withOpacity(0.1)
                                    : Colors.white,
                              ),
                              child: Text(
                                size,
                                style: TextStyle(
                                  color:
                                      selected ? Colors.amber : Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            isWishlisted = !isWishlisted;
                          });
                          widget.onWishlistToggle(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isWishlisted
                                  ? "Added to Wishlist"
                                  : "Removed from Wishlist"),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(
                          isWishlisted ? Icons.favorite : Icons.favorite_border,
                          color: Colors.pink,
                        ),
                        label: const Text(
                          "Wishlist",
                          style: TextStyle(color: Colors.pink),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.amber),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child:
                      ElevatedButton.icon(
                        onPressed: () {
                          widget.onAddToCart(product);
                        },
                        icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white),
                        label: const Text("Add to Bag", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),

                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Product Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Lining Fabric: Unlined\n"
                      "Sport: Yoga\n"
                      "Features: Lightweight\n"
                      "Sustainable: Regular\n"
                      "Technology: Breathable",
                      style: TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

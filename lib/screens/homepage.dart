
import 'package:examsample/screens/product_details_page.dart';
import 'package:examsample/screens/shopNowPage.dart';
import 'package:flutter/material.dart';
import '../../models/category_models.dart';
import '../api/apiServices.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/product_models.dart';
import 'CartPage.dart';
import 'category_product_detailsPage.dart';

class HomePage extends StatefulWidget {
  final List<ProductModel> wishList;
  final Function(ProductModel) onWishlistToggle;

  const HomePage({
    super.key,
    required this.wishList,
    required this.onWishlistToggle,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<dynamic> products = [];
  List<CategoryModel> categories = [];

  List<ProductModel> cartList = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final fetchedProducts = await ApiService.fetchProducts();
      final fetchedCategories = await ApiService.fetchCategories();

      setState(() {
        products = fetchedProducts;
        categories = fetchedCategories;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  void toggleWishlist(Map<String, dynamic> product) {
    final productModel = ProductModel(
      name: product["name"],
      price: (product["price"] as num).toDouble(),
      image: product["image"],
      rating: (product["rating"] as num).toDouble(),
      reviews: product["reviews"],
    );

    final isWishlisted =
        widget.wishList.any((item) => item.name == product["name"]);

    widget.onWishlistToggle(productModel);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isWishlisted ? "Removed from Wishlist" : "Added to Wishlist",
        ),
        duration: Duration(seconds: 1),
      ),
    );

    setState(() {});
  }

  void addToCart(ProductModel product) {
    final exists = cartList.any((item) => item.name == product.name);

    if (!exists) {
      setState(() {
        cartList.add(product);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Added to Cart"),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Already in Cart"),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Fashion Hub",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartPage(cartList: cartList),
                    ),
                  );
                },
              ),
              if (cartList.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.red,
                    child: Text(
                      cartList.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    CarouselSlider(
                      options: CarouselOptions(
                        height: 180,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1.0,
                        aspectRatio: 16 / 9,
                        autoPlayInterval: Duration(seconds: 3),
                      ),
                      items: [
                        _buildBanner('assets/images/img1.jpg',
                            'NEW COLLECTIONS', '20% OFF'),
                        _buildBanner('assets/images/jeans.jpg', 'JEANS ON SALE',
                            '30% OFF'),
                        _buildBanner('assets/images/winter.jpg',
                            'WINTER SPECIAL', '15% OFF'),
                      ],
                    ),
                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Shop By Category",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("See All",
                            style: TextStyle(color: Colors.blueAccent)),
                      ],
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return GestureDetector(
                            onTap: () {
                              debugPrint("${category.name}");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryProductDetailspage(
                                      categoryName: category.name),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundImage:
                                        NetworkImage(category.image),
                                  ),
                                  SizedBox(height: 6),
                                  Text(category.name,
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),


                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Curated For You",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("See All",
                            style: TextStyle(color: Colors.blueAccent)),
                      ],
                    ),
                    SizedBox(height: 12),

                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        final isWishlisted = widget.wishList
                            .any((item) => item.name == product["name"]);

                        return GestureDetector(
                          onTap: () {
                            final productModel = ProductModel(
                              name: product["name"],
                              price: product["price"].toDouble(),
                              image: product["image"],
                              rating: product["rating"].toDouble(),
                              reviews: product["reviews"],
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductDetailPage(
                                  product: productModel,
                                  isWishlisted: isWishlisted,
                                  onWishlistToggle: (updatedProduct) {
                                    toggleWishlist(product);
                                  },
                                  onAddToCart: (product) {
                                    addToCart(product);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            CartPage(cartList: cartList),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          child: _buildProductCard(product, isWishlisted),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, bool isWishlisted) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  product["image"],
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: GestureDetector(
                  onTap: () => toggleWishlist(product),
                  child: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    color: isWishlisted ? Colors.red : Colors.redAccent,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product["name"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text("H&M", style: TextStyle(color: Colors.grey)),
                    SizedBox(width: 4),
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    Text("${product["rating"]} (${product["reviews"]})",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "₹${product["price"]}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(String imagePath, String title, String subtitle) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Image.asset(
            imagePath,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                Text(subtitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24)),
                const SizedBox(height: 6),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShopNowPage(),
                      ),
                    );
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text("SHOP NOW",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

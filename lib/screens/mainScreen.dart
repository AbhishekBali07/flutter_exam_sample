import 'package:flutter/material.dart';
import '../models/product_models.dart';
import 'allCategoryPage.dart';
import 'homepage.dart';
import 'wishlistPage.dart';
import 'profilePage.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<ProductModel> wishList = [];

  void toggleWishlist(ProductModel product) {
    setState(() {
      final isWishlisted = wishList.any((item) => item.name == product.name);
      if (isWishlisted) {
        wishList.removeWhere((item) => item.name == product.name);
      } else {
        wishList.add(product);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        wishList: wishList,
        onWishlistToggle: toggleWishlist,
      ),
      const CategoryPage(), // ✅ Replaced SearchPage
      Wishlistpage(
        wishList: wishList,
        onWishlistToggle: toggleWishlist,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            activeIcon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

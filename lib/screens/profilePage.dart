import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/authcontroller.dart';
import 'addressPage.dart';
import 'loginPage.dart';
import 'orderPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final name = authController.userName ?? '';
    final email = authController.userEmail ?? '';
    final phone = authController.phoneNumber ?? '';

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "My Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name.isNotEmpty ? name : "Add your name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: name.isNotEmpty
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          email.isNotEmpty ? email : "Add your email",
                          style: TextStyle(
                            color: email.isNotEmpty
                                ? Colors.black54
                                : Colors.grey,
                          ),
                        ),
                        Text(
                          phone,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: _editProfileDialog,
                  ),
                ],
              ),
            ),


            Container(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_outlined,
                        color: Colors.orange),
                    title: const Text("My Orders"),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const OrderPage()),
                      );
                    },
                  ),
                  const Divider(height: 0),
                  ListTile(
                    leading: const Icon(Icons.location_on_outlined,
                        color: Colors.redAccent),
                    title: const Text("My Addresses"),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AddressPage()),
                      );
                    },
                  ),
                ],
              ),
            ),


            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logged out successfully!")),
                  );
                  // Optional: Clear data
                   Get.offAll(() => const LoginPage());
                },
                icon: const Icon(Icons.logout,color: Colors.white,),
                label: const Text("Logout",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editProfileDialog() {
    final nameCtrl = TextEditingController(text: authController.userName ?? '');
    final emailCtrl = TextEditingController(text: authController.userEmail ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Profile"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Full Name"),
              ),
              TextField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: "Email"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                authController.userName = nameCtrl.text.trim();
                authController.userEmail = emailCtrl.text.trim();
              });
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}

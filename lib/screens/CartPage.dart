import 'package:flutter/material.dart';
import '../models/product_models.dart';

class CartPage extends StatefulWidget {
  final List<ProductModel> cartList;

  const CartPage({super.key, required this.cartList});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<ProductModel, int> quantities = {};


  List<Map<String, String>> addressList = [
    {
      "name": "Abhishek",
      "pin": "718401",
      "address": " Hugli, West Bengal",
    },
    {
      "name": "Rohit Sharma",
      "pin": "400001",
      "address": "Marine Drive, Mumbai, Maharashtra",
    },
  ];

  int selectedAddressIndex = 0;

  @override
  void initState() {
    super.initState();
    for (var product in widget.cartList) {
      quantities[product] = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var product in widget.cartList) {
      total += product.price * quantities[product]!;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.5,
      ),
      body: widget.cartList.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined,
                size: 80, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "Your cart is empty",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            const SizedBox(height: 8),
            const Text(
              "Add items to your cart to see them here.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ) : SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deliver to: ${addressList[selectedAddressIndex]['name']}, ${addressList[selectedAddressIndex]['pin']}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    addressList[selectedAddressIndex]['address']!,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => _showAddressDialog(context),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                    ),
                    child: const Text(
                      "Change / Add",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            ...widget.cartList.map((product) {
              return Container(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(product.image,
                            width: 100, height: 100, fit: BoxFit.cover),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              const Text("Seller: BUZZINDIA",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    "₹${product.price.toStringAsFixed(0)}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "₹${(product.price * 1.35).toStringAsFixed(0)}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    "35% off",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),


                    Row(
                      children: [
                        const Text("Qty:",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (quantities[product]! > 1) {
                                      quantities[product] =
                                          quantities[product]! - 1;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove, size: 18),
                              ),
                              Text("${quantities[product]}",
                                  style: const TextStyle(fontSize: 14)),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quantities[product] =
                                        quantities[product]! + 1;
                                  });
                                },
                                icon: const Icon(Icons.add, size: 18),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.cartList.remove(product);
                            });
                          },
                          child: const Text("Remove",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),

                    const Divider(),
                    const Text("Delivery by Nov 3, Mon",
                        style: TextStyle(color: Colors.black54)),
                  ],
                ),
              );
            }),

            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Price Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  const Divider(thickness: 1),
                  _priceRow("Price (${widget.cartList.length} item)",
                      "₹${(total * 1.35).toStringAsFixed(0)}"),
                  _priceRow("Discount", "-₹${(total * 0.35).toStringAsFixed(0)}",
                      color: Colors.green),
                  _priceRow("Protect Promise Fee", "₹129"),
                  const Divider(thickness: 1),
                  _priceRow("Total Amount", "₹${(total + 129).toStringAsFixed(0)}",
                      isBold: true),
                  const SizedBox(height: 10),
                  Text(
                    "You will save ₹${(total * 0.35).toStringAsFixed(0)} on this order!",
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        ),
      ),


      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: const Text("Place Order",
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }


  void _showAddressDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController pinController = TextEditingController();
    TextEditingController addressController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, top: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Select or Add Address",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              const Divider(),

              // 🔸 Address List
              ...List.generate(addressList.length, (index) {
                final addr = addressList[index];
                return RadioListTile<int>(
                  title: Text("${addr['name']} - ${addr['pin']}"),
                  subtitle: Text(addr['address']!),
                  value: index,
                  groupValue: selectedAddressIndex,
                  onChanged: (value) {
                    setState(() => selectedAddressIndex = value!);
                    Navigator.pop(context);
                  },
                );
              }),

              const Divider(),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration:
                      const InputDecoration(labelText: "Name"),
                    ),
                    TextField(
                      controller: pinController,
                      decoration:
                      const InputDecoration(labelText: "Pin Code"),
                      keyboardType: TextInputType.number,
                    ),
                    TextField(
                      controller: addressController,
                      decoration:
                      const InputDecoration(labelText: "Full Address"),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            pinController.text.isNotEmpty &&
                            addressController.text.isNotEmpty) {
                          setState(() {
                            addressList.add({
                              "name": nameController.text,
                              "pin": pinController.text,
                              "address": addressController.text,
                            });
                            selectedAddressIndex = addressList.length - 1;
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text("Add Address",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _priceRow(String title, String value,
      {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight:
                  isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  color: color ?? Colors.black87,
                  fontWeight:
                  isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

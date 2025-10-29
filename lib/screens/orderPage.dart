import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  final List<Map<String, String>> orders = const [
    {
      "orderId": "ORD12345",
      "status": "Delivered",
      "date": "Oct 22, 2025",
      "total": "₹1299",
    },
    {
      "orderId": "ORD12346",
      "status": "Out for Delivery",
      "date": "Oct 28, 2025",
      "total": "₹899",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Orders",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: orders.isEmpty
          ? const Center(
          child: Text(
            "No Orders Found",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ))
          : ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: const Icon(Icons.shopping_bag_outlined,
                    color: Colors.orange),
                title: Text("Order ID: ${order['orderId']}"),
                subtitle: Text(
                    "Status: ${order['status']}\nDate: ${order['date']}"),
                trailing: Text(order['total']!,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            );
          }),
    );
  }
}

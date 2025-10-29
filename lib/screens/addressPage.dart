import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<Map<String, String>> addressList = [
    {
      "name": "Abhishek",
      "pin": "712401",
      "address": "Muktarpur Bali Para, Hugli, West Bengal",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("My Addresses",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: addressList.isEmpty
          ? const Center(
          child: Text(
            "No Addresses Found",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ))
          : ListView.builder(
          itemCount: addressList.length,
          itemBuilder: (context, index) {
            final addr = addressList[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: const Icon(Icons.location_on,
                    color: Colors.redAccent),
                title: Text("${addr['name']} - ${addr['pin']}"),
                subtitle: Text(addr['address']!),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAddressDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addAddressDialog() {
    TextEditingController nameCtrl = TextEditingController();
    TextEditingController pinCtrl = TextEditingController();
    TextEditingController addrCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Address"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: pinCtrl, decoration: const InputDecoration(labelText: "Pin Code"), keyboardType: TextInputType.number),
            TextField(controller: addrCtrl, decoration: const InputDecoration(labelText: "Full Address")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (nameCtrl.text.isNotEmpty && pinCtrl.text.isNotEmpty && addrCtrl.text.isNotEmpty) {
                setState(() {
                  addressList.add({
                    "name": nameCtrl.text,
                    "pin": pinCtrl.text,
                    "address": addrCtrl.text,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}

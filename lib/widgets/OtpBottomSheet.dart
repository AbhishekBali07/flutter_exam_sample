import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpBottomSheet extends StatefulWidget {
  final String mockOtp;
  final VoidCallback onVerified;

  const OtpBottomSheet({
    super.key,
    required this.mockOtp,
    required this.onVerified,
  });

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  int focusedIndex = -1;

  final Color primaryColor = Colors.blueAccent;
  final Color inactiveBorder = Colors.grey.shade400;
  final Color boxFillColor = Colors.blue.shade50;

  void checkOtp() {
    String enteredOtp =
    _controllers.map((controller) => controller.text).join();

    if (enteredOtp == widget.mockOtp) {
      widget.onVerified();
    } else {
      Get.snackbar(
        "Invalid",
        "Incorrect OTP",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
        colorText: Colors.red.shade700,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        setState(() {
          focusedIndex = _focusNodes[i].hasFocus ? i : focusedIndex;
          if (!_focusNodes[i].hasFocus && focusedIndex == i) {
            focusedIndex = -1;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 24,
          left: 24,
          right: 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Enter OTP",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text("Mock OTP: ${widget.mockOtp}",
                style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                bool isFocused = focusedIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: boxFillColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isFocused ? primaryColor : inactiveBorder,
                      width: isFocused ? 2 : 1,
                    ),
                    boxShadow: isFocused
                        ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ]
                        : [],
                  ),
                  child: Center(
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        counterText: "",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index + 1]);
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context)
                              .requestFocus(_focusNodes[index - 1]);
                        }
                      },
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: checkOtp,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Verify OTP", style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

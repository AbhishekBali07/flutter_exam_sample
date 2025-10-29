
import 'package:examsample/screens/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../widgets/OtpBottomSheet.dart';


class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final mockOtp = "1234";

  void sendOtp() {
    if (phoneController.text.isEmpty) {
      Get.snackbar("Error", "Please enter phone number",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    Get.bottomSheet(
      OtpBottomSheet(
        mockOtp: mockOtp,
        onVerified: verifyOtp,
      ),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }

  void verifyOtp() {
    Get.back(); // close bottom sheet
   // Get.off(() => HomePage());
    Get.off(()=> MainScreen());
  }
}

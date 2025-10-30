import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/homepage.dart';
import '../screens/mainScreen.dart';
import '../widgets/OtpBottomSheet.dart';

class AuthController extends GetxController {
  final phoneController = TextEditingController();
  final mockOtp = "1234";

  String? phoneNumber;
  String? userName;
  String? userEmail;

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
    phoneNumber = phoneController.text;
    Get.back();
    Get.off(() => const MainScreen());
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}


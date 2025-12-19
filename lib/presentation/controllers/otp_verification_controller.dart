import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../app/routes/app_pages.dart';

class OtpVerificationController extends GetxController {
  final VerifyOtpUseCase verifyOtpUseCase;

  OtpVerificationController(this.verifyOtpUseCase);

  final List<TextEditingController> otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  final remainingSeconds = 180.obs;
  Timer? _timer;
  final isLoading = false.obs;
  final errorMessage = RxnString();
  late String email;
  String? _flow;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      email = args['email'] ?? '';
      _flow = args['flow'];
    } else if (args is String) {
      email = args;
    }
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.onClose();
  }

  void startTimer() {
    remainingSeconds.value = 180;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void onDigitChanged(int index, String value) {
    if (errorMessage.value != null) {
      errorMessage.value = null; // Clear error on typing
    }
    if (value.isNotEmpty) {
      if (index < 5) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
        verify(); // Auto-verify on last digit
      }
    } else {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  Future<void> verify() async {
    String otp = otpControllers.map((e) => e.text).join();
    if (otp.length < 6) {
      errorMessage.value = "Enter 6 digits";
      return;
    }

    if (remainingSeconds.value == 0) {
      Get.snackbar("Error", "OTP Expired. Please resend.");
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;

    try {
      final success = await verifyOtpUseCase(email, otp);
      if (success) {
        Get.snackbar('Success', 'OTP Verified!');
        if (_flow == 'LOGIN_OTP') {
          Get.offAllNamed(Routes.home);
        } else {
          Get.toNamed(Routes.resetPassword, arguments: email);
        }
      } else {
        errorMessage.value = "Invalid OTP";
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void resendCode() {
    startTimer();
    Get.snackbar('Sent', 'OTP Resent to $email');
    // Clear fields
    for (var c in otpControllers) c.clear();
    focusNodes[0].requestFocus();
  }

  void goBack() {
    Get.back();
  }
}

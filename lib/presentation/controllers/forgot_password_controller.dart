import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/send_password_reset_usecase.dart';
import '../../app/routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final SendPasswordResetUseCase sendPasswordResetUseCase;

  ForgotPasswordController(this.sendPasswordResetUseCase);

  final emailController = TextEditingController();
  final isLoading = false.obs;
  final emailError = RxnString();

  bool validate() {
    bool isValid = true;
    emailError.value = null;

    if (emailController.text.isEmpty) {
      emailError.value = 'Email cannot be empty';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Invalid Email';
      isValid = false;
    }
    return isValid;
  }

  Future<void> submit() async {
    if (!validate()) return;

    isLoading.value = true;
    try {
      await sendPasswordResetUseCase(emailController.text);
      Get.snackbar(
        'Success',
        'Password reset link sent to ${emailController.text}',
      );
      Get.toNamed(Routes.otpVerification, arguments: emailController.text);
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }
}

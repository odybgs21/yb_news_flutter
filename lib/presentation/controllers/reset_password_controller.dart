import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../app/routes/app_pages.dart';

class ResetPasswordController extends GetxController {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordController(this.resetPasswordUseCase);

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isNewPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isLoading = false.obs;

  final newPasswordError = RxnString();
  final confirmPasswordError = RxnString();

  late String email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments as String? ?? '';
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool validate() {
    bool isValid = true;
    newPasswordError.value = null;
    confirmPasswordError.value = null;

    final newPass = newPasswordController.text;
    final confirmPass = confirmPasswordController.text;

    if (newPass.isEmpty) {
      newPasswordError.value = 'Password cannot be empty';
      isValid = false;
    } else if (newPass.length < 6) {
      newPasswordError.value = 'Password must be at least 6 characters';
      isValid = false;
    }

    if (confirmPass.isEmpty) {
      confirmPasswordError.value = 'Confirm Password cannot be empty';
      isValid = false;
    } else if (newPass != confirmPass) {
      confirmPasswordError.value = 'Passwords do not match';
      isValid = false;
    }

    return isValid;
  }

  Future<void> submit() async {
    if (!validate()) return;

    final newPass = newPasswordController.text;

    isLoading.value = true;
    try {
      await resetPasswordUseCase(email, newPass);
      Get.snackbar('Success', 'Password reset successfully!');
      Get.offAllNamed(Routes.login);
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

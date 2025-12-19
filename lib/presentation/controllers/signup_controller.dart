import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../app/routes/app_pages.dart';

class SignUpController extends GetxController {
  final SignUpUseCase signUpUseCase;

  SignUpController(this.signUpUseCase);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isRememberMe = false.obs;

  final emailError = RxnString();
  final passwordError = RxnString();
  final confirmPasswordError = RxnString();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  bool validate() {
    bool isValid = true;
    final nameError = RxnString();
    emailError.value = null;
    passwordError.value = null;
    confirmPasswordError.value = null; // New error observable needed

    if (nameController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Name cannot be empty",
      ); // Or handle with error text
      isValid = false;
    }

    if (emailController.text.isEmpty) {
      emailError.value = 'Email cannot be empty';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Invalid Email';
      isValid = false;
    }

    // Password Validation: 8 chars, Alphanumeric
    final password = passwordController.text;
    if (password.isEmpty) {
      passwordError.value = 'Password cannot be empty';
      isValid = false;
    } else {
      bool hasMinLength = password.length >= 8;
      bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
      bool hasDigit = password.contains(RegExp(r'[0-9]'));

      if (!hasMinLength || !hasLetter || !hasDigit) {
        passwordError.value = 'Password must be 8+ chars, alphanumeric';
        isValid = false;
      }
    }

    if (isValid) {
      // Check confirmation matches
      if (confirmPasswordController.text != passwordController.text) {
        confirmPasswordError.value = 'Passwords do not match';
        isValid = false;
      }
    }

    return isValid;
  }

  Future<void> signUp() async {
    if (!validate()) return;

    isLoading.value = true;
    try {
      await signUpUseCase(
        emailController.text,
        passwordController.text,
        nameController.text,
      );
      Get.snackbar('Success', 'Account created! Please login.');
      Get.offAllNamed(Routes.login);
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void goToLogin() {
    Get.back();
  }
}

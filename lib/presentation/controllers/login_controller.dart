import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/routes/app_pages.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController({required this.loginUseCase});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;
  final isRememberMe = false.obs;

  final emailError = RxnString();
  final passwordError = RxnString();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    isRememberMe.value = !isRememberMe.value;
  }

  bool validate() {
    bool isValid = true;
    emailError.value = null;
    passwordError.value = null;

    if (emailController.text.isEmpty) {
      emailError.value = 'Email cannot be empty';
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text)) {
      emailError.value = 'Invalid Email';
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = 'Password cannot be empty';
      isValid = false;
    }

    return isValid;
  }

  Future<void> login() async {
    if (!validate()) return;

    isLoading.value = true;
    try {
      final user = await loginUseCase(
        emailController.text,
        passwordController.text,
      );

      if (user.isFirstLogin) {
        Get.snackbar(
          'Verification Required',
          'Please verify your email via OTP.',
        );
        Get.toNamed(
          Routes.otpVerification,
          arguments: {'email': emailController.text, 'flow': 'LOGIN_OTP'},
        );
      } else {
        Get.snackbar('Success', 'Welcome back, ${user.name}!');
        Get.offAllNamed(Routes.home);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}

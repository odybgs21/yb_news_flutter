import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordPage extends GetView<ResetPasswordController> {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: controller.goBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Reset',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E3E55),
                height: 1.2,
              ),
            ),
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3E3E55),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 40),

            // New Password
            Row(
              children: const [
                Text(
                  "New Password",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text("*", style: TextStyle(color: Colors.pink)),
              ],
            ),
            const SizedBox(height: 8),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.newPasswordController,
                    obscureText: !controller.isNewPasswordVisible.value,
                    onChanged: (_) => controller.newPasswordError.value = null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: controller.newPasswordError.value != null
                          ? const Color(0xFFFFF0F3)
                          : Colors.transparent,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isNewPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: controller.newPasswordError.value != null
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: controller.toggleNewPasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: controller.newPasswordError.value != null
                              ? Colors.red
                              : Colors.grey[400]!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: controller.newPasswordError.value != null
                              ? Colors.red
                              : Colors.grey[400]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: controller.newPasswordError.value != null
                              ? Colors.red
                              : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  if (controller.newPasswordError.value != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          controller.newPasswordError.value!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Password
            Row(
              children: const [
                Text(
                  "Confirm new password",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text("*", style: TextStyle(color: Colors.pink)),
              ],
            ),
            const SizedBox(height: 8),
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.confirmPasswordController,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    onChanged: (_) =>
                        controller.confirmPasswordError.value = null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: controller.confirmPasswordError.value != null
                          ? const Color(0xFFFFF0F3)
                          : Colors.transparent,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: controller.confirmPasswordError.value != null
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: controller.confirmPasswordError.value != null
                              ? Colors.red
                              : Colors.grey[400]!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: controller.confirmPasswordError.value != null
                              ? Colors.red
                              : Colors.grey[400]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: controller.confirmPasswordError.value != null
                              ? Colors.red
                              : Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  if (controller.confirmPasswordError.value != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          controller.confirmPasswordError.value!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.submit(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import '../../domain/usecases/send_password_reset_usecase.dart';
import '../../presentation/controllers/forgot_password_controller.dart';
import '../../domain/repositories/auth_repository.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ForgotPasswordController(Get.find<SendPasswordResetUseCase>()),
    );
    Get.lazyPut(() => SendPasswordResetUseCase(Get.find<AuthRepository>()));
  }
}

import 'package:get/get.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../presentation/controllers/reset_password_controller.dart';
import '../../domain/repositories/auth_repository.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ResetPasswordController(Get.find<ResetPasswordUseCase>()),
    );
    Get.lazyPut(() => ResetPasswordUseCase(Get.find<AuthRepository>()));
  }
}

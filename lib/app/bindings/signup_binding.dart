import 'package:get/get.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../presentation/controllers/signup_controller.dart';
import '../../domain/repositories/auth_repository.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController(Get.find<SignUpUseCase>()));
    Get.lazyPut(() => SignUpUseCase(Get.find<AuthRepository>()));
  }
}

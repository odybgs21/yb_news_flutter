import 'package:get/get.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import '../../presentation/controllers/otp_verification_controller.dart';
import '../../domain/repositories/auth_repository.dart';

class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpVerificationController(Get.find<VerifyOtpUseCase>()));
    Get.lazyPut(() => VerifyOtpUseCase(Get.find<AuthRepository>()));
  }
}

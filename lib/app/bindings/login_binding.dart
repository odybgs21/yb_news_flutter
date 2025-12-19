import 'package:get/get.dart';
import '../../data/providers/auth_provider.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../presentation/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginUseCase(Get.find<AuthRepository>()));
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(authProvider: Get.find<AuthProvider>()),
    );
    Get.lazyPut(() => AuthProvider());
    Get.lazyPut(() => LoginController(loginUseCase: Get.find()));
  }
}

import '../repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<bool> call(String email, String otp) async {
    return await repository.verifyOtp(email, otp);
  }
}

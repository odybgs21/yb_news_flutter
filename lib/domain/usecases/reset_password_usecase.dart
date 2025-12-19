import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> call(String email, String newPassword) async {
    return await repository.resetPassword(email, newPassword);
  }
}

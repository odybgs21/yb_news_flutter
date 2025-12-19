import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> signUp(String email, String password, String name);
  Future<void> sendPasswordReset(String email);
  Future<bool> verifyOtp(String email, String otp);
  Future<void> resetPassword(String email, String newPassword);
}

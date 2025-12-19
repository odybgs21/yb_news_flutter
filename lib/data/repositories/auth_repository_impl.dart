import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider authProvider; // Renamed 'provider' to 'authProvider'

  AuthRepositoryImpl({
    required this.authProvider,
  }); // Updated constructor parameter

  @override
  Future<UserEntity> login(String email, String password) async {
    final data = await authProvider.login(email, password);
    return UserModel.fromJson(data);
  }

  @override
  Future<UserEntity> signUp(String email, String password, String name) async {
    final data = await authProvider.signUp(email, password, name);
    return UserModel.fromJson(data);
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    await authProvider.sendPasswordReset(email);
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    return await authProvider.verifyOtp(email, otp);
  }

  @override
  Future<void> resetPassword(String email, String newPassword) async {
    await authProvider.resetPassword(email, newPassword);
  }
}

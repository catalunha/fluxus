import 'package:fluxus/app/core/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> readByEmail(String email);
  Future<UserModel?> register(
      {required String email, required String password});
  Future<UserModel?> login({required String email, required String password});
  Future<bool> logout();
  Future<void> forgotPassword(String email);
}

import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/infrastructure/repository/auth_repository.dart';
import 'package:restaurant_review/domain/entities/user.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase({required this.authRepository});

  Future<Map<String, dynamic>> signup({
    required String username,
    required String email,
    required String password,
    required UserType userType,
  }) async {
    final user = await authRepository.signUp(
      username: username,
      email: email,
      password: password,
      userType: userType,
    );
    return user;
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final user = await authRepository.login(
      username: username,
      password: password,
    );
    return user;
  }
}

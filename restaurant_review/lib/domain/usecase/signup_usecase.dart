import 'package:restaurant_review/models/user_types.dart';
import 'package:restaurant_review/infrastructure/repository/sign_up_repository.dart';
import 'package:restaurant_review/domain/entities/user.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase({required this.authRepository});

  Future<Map<String, dynamic>> execute({
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
}

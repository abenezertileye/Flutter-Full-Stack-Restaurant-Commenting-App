import 'package:restaurant_review/infrastructure/repository/login_repository.dart';
import 'package:restaurant_review/domain/entities/user.dart';

class LogInUseCase {
  final LoginAuthRepository loginAuthRepository;

  LogInUseCase({required this.loginAuthRepository});

  Future<Map<String, dynamic>> execute({
    required String email,
    required String password,
  }) async {
    print('in login usecase');
    final user = await loginAuthRepository.login(
      email: email,
      password: password,
    );
    return user;
  }
}

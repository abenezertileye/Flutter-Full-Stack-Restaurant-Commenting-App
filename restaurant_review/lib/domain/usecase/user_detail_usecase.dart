import 'package:restaurant_review/infrastructure/repository/restaurants_repository.dart';
import 'package:restaurant_review/domain/entities/user_detail_entity.dart';
import 'package:restaurant_review/infrastructure/repository/user_detail_repository.dart';

class UserUseCase {
  final UserRepository userRepository;

  UserUseCase({required this.userRepository});

  Future<UserDetail> fetchUserData(userId) async {
    final user = await userRepository.fetchUser(userId);
    print('user in user usecase: $user');
    return user;
  }

  Future<String> updatePassword(
      {required String userId,
      required String oldPassword,
      required String newPassword}) async {
    final message = await userRepository.updatePasswordReq(
        userId: userId, oldPassword: oldPassword, newPassword: newPassword);
    return message;
  }

  Future<String> deleteAccount(userId) async {
    final message = await userRepository.deleteAccountReq(userId);
    return message;
  }
}

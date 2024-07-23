import 'package:core/data/models/user.dart';
import 'package:core/data/network/mock_user_service.dart';

abstract class UserRepository {
  Future<User> getUserData();
  Future<void> addBeneficiary(String nickname, String phoneNumber);
  Future<void> topUp(double amount, String beneficiaryId);
}

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl({required this.apiService});

  @override
  Future<User> getUserData() async {
    try {
      //This data can come from server or Local storage service in a real world app
      final user = await apiService.getUserData();
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addBeneficiary(String nickname, String phoneNumber) {
    try {
      return apiService.addBeneficiary(nickname, phoneNumber);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> topUp(double amount, String beneficiaryId) {
    try {
      return apiService.topUp(amount, beneficiaryId);
    } catch (e) {
      rethrow;
    }
  }
}

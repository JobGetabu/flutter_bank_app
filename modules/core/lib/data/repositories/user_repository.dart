import 'package:core/data/models/user.dart';
import 'package:core/data/network/mock_user_service.dart';

abstract class UserRepository {
  Future<User> getUserData();
}

class UserRepositoryImpl implements UserRepository{
  final ApiService apiService;

  UserRepositoryImpl({required this.apiService});

  @override
  Future<User> getUserData() async {
    try{

      //This data can come from server or Local storage service in a real world app
      final user = await apiService.getUserData();
      return user;
    }catch(e) {
      rethrow;
    }
  }

}
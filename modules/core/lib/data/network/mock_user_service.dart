import 'package:core/data/models/user.dart';

abstract class ApiService {
  Future<User> getUserData();
}

//replace with real API service
class MockUserService extends ApiService {
  @override
  Future<User> getUserData() async {
    // Simulate a network delay (optional)
    await Future.delayed(const Duration(seconds: 1));

    // Return your mock user data
    // Use In-app memory data
    return User(
      id: "12345",
      name: 'Job Getabu',
      isVerified: true,
      balance: 5000.0,
      monthlyTopUpTotal: 0,
    );
  }
}

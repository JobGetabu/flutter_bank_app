import 'package:bloc/bloc.dart';
import 'package:core/data/models/user.dart';
import 'package:core/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  final UserRepository userRepository;

  UserDetailCubit({required this.userRepository}) : super(UserDetailInitial());

  Future getUserDetails() async {
    emit(UserDetailLoadingState());
    try {
      final user = await userRepository.getUserData();
      emit(UserDetailLoadedState(user: user));
    }catch (e) {
      emit(const UserDetailErrorState('Error fetching user details!'));
    }
  }

}

part of 'user_detail_cubit.dart';

sealed class UserDetailState extends Equatable {
  const UserDetailState();
}

final class UserDetailInitial extends UserDetailState {
  @override
  List<Object> get props => [];
}

class UserDetailLoadingState extends UserDetailState {
  @override
  List<Object> get props => [];
}

class UserDetailErrorState extends UserDetailState {
  final String message;

  const UserDetailErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class UserDetailLoadedState extends UserDetailState {
  final User user;

  const UserDetailLoadedState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

part of 'top_up_cubit.dart';

enum TopUpStatus { initial, loading, success, failure }

class TopUpState extends Equatable {
  final User? user;
  final List<Beneficiary> beneficiaries;
  final List<Transaction> transactions;
  final TopUpStatus status;
  final String? errorMessage;

  const TopUpState(
      {this.user,
      this.beneficiaries = const [],
      this.transactions = const [],
      this.status = TopUpStatus.initial,
      this.errorMessage});

  TopUpState copyWith({
    User? user,
    List<Beneficiary>? beneficiaries,
    List<Transaction>? transactions,
    TopUpStatus? status,
    String? errorMessage,
  }) {
    return TopUpState(
      user: user ?? this.user,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      transactions: transactions ?? this.transactions,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [user, beneficiaries, transactions, status, errorMessage];
}

final class TopUpInitial extends TopUpState {
  @override
  List<Object> get props => [];
}

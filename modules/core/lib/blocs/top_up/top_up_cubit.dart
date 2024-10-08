import 'package:core/data/models/top_up_option.dart';
import 'package:dependencies/dependencies.dart';
import 'package:core/data/models/beneficiary.dart';
import 'package:core/data/models/transactions.dart';
import 'package:core/data/models/user.dart';
import 'package:core/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'top_up_state.dart';

//Acting as In-App memory store
class TopUpCubit extends Cubit<TopUpState> {
  final UserRepository userRepository;

  TopUpCubit({required this.userRepository}) : super(TopUpInitial());

  //Per month
  final double nonVerifiedMaxTopUp = 1000.0;
  final double verifiedMaxTopUp = 500.0;
  final double totalMaximumTopUp = 3000.0;

  final double topUpFee = 1.0;
  List<double> topUpOptions = [5, 10, 20, 30, 50, 75, 100];

  void simulateInitilizingUser() async {
    final user = await userRepository.getUserData();

    initializeUser(user.id, user.name, user.isVerified, user.balance,
        user.monthlyTopUpTotal);
  }

  void initializeUser(String id, String name, bool isVerified,
      double initialBalance, double monthlyTopUpTotal) {
    final user = User(
        id: id,
        name: name,
        isVerified: isVerified,
        balance: initialBalance,
        monthlyTopUpTotal: monthlyTopUpTotal);
    emit(state.copyWith(user: user, status: TopUpStatus.success));
  }

  void addBeneficiary(String nickname, String phoneNumber) {
    if (state.beneficiaries.length >= 5) {
      emit(state.copyWith(
        status: TopUpStatus.formErrors,
        errorMessage: 'Maximum number of beneficiaries (5) reached.',
      ));
      return;
    }

    if (nickname.length > 20) {
      emit(state.copyWith(
        status: TopUpStatus.formErrors,
        errorMessage: 'Nickname must be 20 characters or less.',
      ));
      return;
    }

    final newBeneficiary = Beneficiary(
        id: DateTime.now().toString(), // Simple ID generation
        nickname: nickname,
        phoneNumber: phoneNumber,
        monthlyTopUp: 0);

    //mock api call
    userRepository.addBeneficiary(nickname, phoneNumber);

    emit(state.copyWith(
      beneficiaries: [...state.beneficiaries, newBeneficiary],
      status: TopUpStatus.success,
    ));
  }

  bool canTopUp(String beneficiaryId, double amount) {
    if (state.user == null) return false;

    final beneficiary =
        state.beneficiaries.firstWhere((b) => b.id == beneficiaryId);
    double maxMonthly =
        state.user!.isVerified ? verifiedMaxTopUp : nonVerifiedMaxTopUp;

    if (beneficiary.monthlyTopUp + amount > maxMonthly) return false;
    if (state.user!.monthlyTopUpTotal + amount > totalMaximumTopUp) {
      return false;
    }
    if (state.user!.balance < amount + topUpFee) {
      return false; // + transaction fee
    }

    return true;
  }

  topUp(String beneficiaryId, double amount) async {
    if (!canTopUp(beneficiaryId, amount)) {
      emit(state.copyWith(
        status: TopUpStatus.topUpFailure,
        errorMessage: 'Top-up not allowed. Check limits and balance.',
      ));
      return;
    }

    final updatedUser = state.user!.copyWith(
      balance: state.user!.balance - (amount + 1),
      monthlyTopUpTotal: state.user!.monthlyTopUpTotal + amount,
    );

    final updatedBeneficiaries = state.beneficiaries.map((b) {
      if (b.id == beneficiaryId) {
        return b.copyWith(monthlyTopUp: b.monthlyTopUp + amount);
      }
      return b;
    }).toList();

    final newTransaction = Transaction(
      id: DateTime.now().toString(), // Simple ID generation
      beneficiaryId: beneficiaryId,
      amount: amount,
      timestamp: DateTime.now(),
    );

    await userRepository.topUp(amount, beneficiaryId);

    emit(state.copyWith(
      user: updatedUser,
      beneficiaries: updatedBeneficiaries,
      transactions: [...state.transactions, newTransaction],
      status: TopUpStatus.success,
    ));
  }

  double calculateMaxTopUp() {
    if (state.user == null) return 0;

    double remainingMonthlyLimit = totalMaximumTopUp - state.user!.monthlyTopUpTotal;
    double maxBasedOnBalance = state.user!.balance - topUpFee;

    return (remainingMonthlyLimit < maxBasedOnBalance) ? remainingMonthlyLimit : maxBasedOnBalance;

  }

  double calculateMaxTopUpForBeneficiary(String beneficiaryId) {
    if (state.user == null) return 0;

    Beneficiary beneficiary = state.beneficiaries.firstWhere((b) => b.id == beneficiaryId);
    double maxMonthlyPerBeneficiary = state.user!.isVerified ? verifiedMaxTopUp : nonVerifiedMaxTopUp;
    double remainingBeneficiaryLimit = maxMonthlyPerBeneficiary - beneficiary.monthlyTopUp;

    double maxOverall = calculateMaxTopUp();

    return [remainingBeneficiaryLimit, maxOverall].reduce((a, b) => a < b ? a : b);
  }

  List<double> getAvailableTopUpOptions(String beneficiaryId) {
    double maxTopUp = calculateMaxTopUpForBeneficiary(beneficiaryId);
    return topUpOptions.where((amount) => amount <= maxTopUp).toList();
  }

  List<Transaction> getTransactionsForBeneficiary(String beneficiaryId) {
    return state.transactions.where((t) => t.beneficiaryId == beneficiaryId).toList();
  }

  double getBeneficiaryBalance(String beneficiaryId) {
    return state.beneficiaries.firstWhere((b) => b.id == beneficiaryId).monthlyTopUp;
  }

  double getUserBalance() {
    return state.user?.balance ?? 0;
  }

}

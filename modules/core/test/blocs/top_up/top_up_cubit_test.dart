import 'package:bloc_test/bloc_test.dart';
import 'package:core/blocs/top_up/top_up_cubit.dart';
import 'package:core/data/models/beneficiary.dart';
import 'package:core/data/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_up_cubit_test.mocks.dart';

@GenerateMocks([
  UserRepository,
])
void main() {

  group('TopUpCubit', () {
    late TopUpCubit topUpCubit;
    late UserRepository _userRepository;

    setUp(() {
      _userRepository = MockUserRepository();
      
      topUpCubit = TopUpCubit(userRepository: _userRepository);
    });

    tearDown(() {
      topUpCubit.close();
    });

    test('initial state is correct', () {
      expect(topUpCubit.state, TopUpInitial());
    });

    group('initializeUser', () {
      blocTest<TopUpCubit, TopUpState>(
        'emits correct state when user is initialized',
        build: () => topUpCubit,
        act: (cubit) => cubit.initializeUser('1', 'John Doe', true, 1000, 0),
        expect: () => [
          isA<TopUpState>()
              .having((s) => s.user?.id, 'user.id', '1')
              .having((s) => s.user?.name, 'user.name', 'John Doe')
              .having((s) => s.user?.isVerified, 'user.isVerified', true)
              .having((s) => s.user?.balance, 'user.balance', 1000)
              .having((s) => s.status, 'status', TopUpStatus.success),
        ],
      );
    });

    group('addBeneficiary', () {
      setUp(() {
        topUpCubit.initializeUser('1', 'John Doe', true, 1000, 0);
      });

      blocTest<TopUpCubit, TopUpState>(
        'emits correct state when beneficiary is added successfully',
        build: () => topUpCubit,
        act: (cubit) => cubit.addBeneficiary('Mom', '0505123456'),
        expect: () => [
          isA<TopUpState>()
              .having((s) => s.beneficiaries.length, 'beneficiaries.length', 1)
              .having((s) => s.beneficiaries.first.nickname, 'beneficiary.nickname', 'Mom')
              .having((s) => s.beneficiaries.first.phoneNumber, 'beneficiary.phoneNumber', '0505123456')
              .having((s) => s.status, 'status', TopUpStatus.success),
        ],
      );

      blocTest<TopUpCubit, TopUpState>(
        'emits failure state when maximum beneficiaries are reached',
        build: () => topUpCubit,
        seed: () => TopUpState(beneficiaries: List.generate(5, (index) => Beneficiary(id: '$index', nickname: 'Test$index', phoneNumber: '051234567$index, ', monthlyTopUp: 0))),
        act: (cubit) => cubit.addBeneficiary('Extra', '9876543210'),
        expect: () => [
          isA<TopUpState>()
              .having((s) => s.status, 'status', TopUpStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', 'Maximum number of beneficiaries (5) reached.'),
        ],
      );

      blocTest<TopUpCubit, TopUpState>(
        'emits failure state when nickname is too long',
        build: () => topUpCubit,
        act: (cubit) => cubit.addBeneficiary('This is a very long nickname', '0505123456'),
        expect: () => [
          isA<TopUpState>()
              .having((s) => s.status, 'status', TopUpStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', 'Nickname must be 20 characters or less.'),
        ],
      );
    });

    group('canTopUp', () {
      setUp(() {
        topUpCubit.initializeUser('1', 'John Doe', true, 1000, 0);
        topUpCubit.addBeneficiary('Mom', '0505123456');
      });

      test('returns true when top-up is allowed', () {
        expect(topUpCubit.canTopUp(topUpCubit.state.beneficiaries.first.id, 100), isTrue);
      });

      test('returns false when user balance is insufficient', () {
        topUpCubit.initializeUser('1', 'John Doe', true, 50, 0);
        expect(topUpCubit.canTopUp(topUpCubit.state.beneficiaries.first.id, 100), isFalse);
      });

      blocTest<TopUpCubit, TopUpState>(
        'returns false when monthly limit for beneficiary is exceeded',
        build: () => topUpCubit,
        act: (cubit) async {
          final beneficiaryId = cubit.state.beneficiaries.first.id;
          await cubit.topUp(beneficiaryId, 490);
        },
        verify: (cubit) {
          final beneficiaryId = cubit.state.beneficiaries.first.id;
          expect(cubit.canTopUp(beneficiaryId, 20), isFalse);
        },
      );

      test('returns false when total monthly limit is exceeded', () {
        final beneficiaryId = topUpCubit.state.beneficiaries.first.id;
        //topUpCubit.topUp(topUpCubit.state.beneficiaries.first.id, 2990);
        expect(topUpCubit.canTopUp(topUpCubit.state.beneficiaries.first.id, 3001), isFalse);
      });
    });

    group('topUp', () {
      setUp(() {
        topUpCubit.initializeUser('1', 'John Doe', true, 1000, 0);
        topUpCubit.addBeneficiary('Mom', '0505123456');
      });

      blocTest<TopUpCubit, TopUpState>(
        'emits correct state when top-up is successful',
        build: () => topUpCubit,
        act: (cubit) => cubit.topUp(cubit.state.beneficiaries.first.id, 100),
        expect: () => [
          isA<TopUpState>()
              .having((s) => s.user?.balance, 'user.balance', 899)
              .having((s) => s.user?.monthlyTopUpTotal, 'user.monthlyTopUpTotal', 100)
              .having((s) => s.beneficiaries.first.monthlyTopUp, 'beneficiary.monthlyTopUp', 100)
              .having((s) => s.transactions.length, 'transactions.length', 1)
              .having((s) => s.status, 'status', TopUpStatus.success),
        ],
      );

      blocTest<TopUpCubit, TopUpState>(
        'emits failure state when top-up is not allowed',
        build: () => topUpCubit,
        act: (cubit) => cubit.topUp(cubit.state.beneficiaries.first.id, 2000),
        expect: () => [
          isA<TopUpState>()
              .having((s) => s.status, 'status', TopUpStatus.failure)
              .having((s) => s.errorMessage, 'errorMessage', 'Top-up not allowed. Check limits and balance.'),
        ],
      );
    });

    group('getTransactionsForBeneficiary', () {
      setUp(() {
        topUpCubit.initializeUser('1', 'John Doe', true, 1000, 0);
        topUpCubit.addBeneficiary('Mom', '0505123456');
        topUpCubit.topUp(topUpCubit.state.beneficiaries.first.id, 100);
      });

      test('returns correct transactions for a beneficiary', () {
        final transactions = topUpCubit.getTransactionsForBeneficiary(topUpCubit.state.beneficiaries.first.id);
        expect(transactions.length, 1);
        expect(transactions.first.amount, 100);
      });
    });

    group('getBeneficiaryBalance', () {
      setUp(() {
        topUpCubit.initializeUser('1', 'John Doe', true, 1000, 0);
        topUpCubit.addBeneficiary('Mom', '0505123456');
        topUpCubit.topUp(topUpCubit.state.beneficiaries.first.id, 100);
      });

      test('returns correct balance for a beneficiary', () {
        final balance = topUpCubit.getBeneficiaryBalance(topUpCubit.state.beneficiaries.first.id);
        expect(balance, 100);
      });
    });

    group('getUserBalance', () {
      setUp(() {
        topUpCubit.initializeUser('1', 'John Doe', true, 1000, 0);
      });

      test('returns correct user balance', () {
        expect(topUpCubit.getUserBalance(), 1000);
      });
    });

    group('calculateMaxTopUp', () {
      test('returns correct max top-up amount based on balance and monthly limit', () {
        topUpCubit.initializeUser('1', 'John Doe', true, 2000, 0);
        expect(topUpCubit.calculateMaxTopUp(), 1999); // 2000 - 1 (transaction fee)

        topUpCubit.initializeUser('1', 'John Doe', true, 4000, 0);
        expect(topUpCubit.calculateMaxTopUp(), 3000); // Monthly limit
      });
    });

    group('calculateMaxTopUpForBeneficiary', () {
      setUp(() {
        topUpCubit.initializeUser('1', 'John Doe', true, 2000, 0);
        topUpCubit.addBeneficiary('Mom', '0505123456');
      });

      blocTest<TopUpCubit, TopUpState>(
        'returns correct max top-up amount for a beneficiary',
        build: () => topUpCubit,
        act: (cubit) async {
          final beneficiaryId = cubit.state.beneficiaries.first.id;
          final initialMax = cubit.calculateMaxTopUpForBeneficiary(beneficiaryId);
          expect(initialMax, 500); // 500 (max monthly) or 999 (balance - fee), whichever is smaller

          await cubit.topUp(beneficiaryId, 300);
        },
        verify: (cubit) {
          final beneficiaryId = cubit.state.beneficiaries.first.id;
          final updatedMax = cubit.calculateMaxTopUpForBeneficiary(beneficiaryId);
          expect(updatedMax, 200); // 200 (remaining monthly limit) or 698 (remaining balance - fee), whichever is smaller
        },
      );

    });

    group('getAvailableTopUpOptions', () {
      setUp(() {
        topUpCubit.initializeUser('1', 'John Doe', true, 2000, 0);
        topUpCubit.addBeneficiary('Mom', '0505123456');
      });

      blocTest<TopUpCubit, TopUpState>(
        'returns correct available top-up options',
        build: () => topUpCubit,
        act: (cubit) async {
          final beneficiaryId = cubit.state.beneficiaries.first.id;
          final initialOptions = cubit.getAvailableTopUpOptions(beneficiaryId);
          expect(initialOptions, [5, 10, 20, 30, 50, 75, 100]);

          await cubit.topUp(beneficiaryId, 470);
        },
        verify: (cubit) {
          final beneficiaryId = cubit.state.beneficiaries.first.id;
          final updatedOptions = cubit.getAvailableTopUpOptions(beneficiaryId);
          expect(updatedOptions, [5, 10, 20, 30]);
        },
      );

    });
  });

}
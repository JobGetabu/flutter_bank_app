class Beneficiary {
  final String id;
  final String nickname;
  final String phoneNumber;
  final double monthlyTopUp;

  Beneficiary(
      {required this.id,
      required this.nickname,
      required this.phoneNumber,
      required this.monthlyTopUp
      });

  Beneficiary copyWith({
    String? id,
    String? nickname,
    String? phoneNumber,
    double? monthlyTopUp,
  }) {
    return Beneficiary(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      monthlyTopUp: monthlyTopUp ?? this.monthlyTopUp,
    );
  }
}

List<int> topUpOptions = [5, 10, 20, 30, 50, 75, 100];

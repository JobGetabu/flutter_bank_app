class Beneficiary {
  String nickname;
  String phoneNumber;
  double monthlyTopUp;

  Beneficiary({required this.nickname, required this.phoneNumber, this.monthlyTopUp = 0});
}

List<int> topUpOptions = [5, 10, 20, 30, 50, 75, 100];

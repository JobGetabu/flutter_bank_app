class User {
  bool isVerified;
  double balance;
  double monthlyTopUpTotal;

  User({required this.isVerified, required this.balance, this.monthlyTopUpTotal = 0});
}
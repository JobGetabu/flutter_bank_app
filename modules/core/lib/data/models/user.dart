class User {
  final String id;
  final String name;
  final bool isVerified;
  final double monthlyTopUpTotal;
  final double balance;

  User({
    required this.id,
    required this.name,
    required this.isVerified,
    required this.balance,
    required this.monthlyTopUpTotal,
  });

  User copyWith({
    String? id,
    String? name,
    bool? isVerified,
    double? balance,
    double? monthlyTopUpTotal,
  }) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        isVerified: isVerified ?? this.isVerified,
        balance: balance ?? this.balance,
        monthlyTopUpTotal: monthlyTopUpTotal ?? this.monthlyTopUpTotal);
  }
}

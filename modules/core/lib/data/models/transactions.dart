class Transaction {
  final String id;
  final String beneficiaryId;
  final double amount;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.beneficiaryId,
    required this.amount,
    required this.timestamp,
  });
}
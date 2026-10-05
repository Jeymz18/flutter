enum TransactionType { income, expense }

class TransactionItem {
  final int? id; // database ang magbibigay nito mamaya
  final TransactionType type;
  final String title;
  final double amount;
  final String category;
  final DateTime date;
  final String note;
  final DateTime createdAt;

  TransactionItem({
    this.id,
    required this.type,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.note = '',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
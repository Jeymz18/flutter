enum BudgetPeriod { weekly, monthly }

class Budget {
  final int? id;
  final BudgetPeriod period;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;

  const Budget({
    this.id,
    required this.period,
    required this.amount,
    required this.startDate,
    required this.endDate,
  });

  String get periodLabel =>
      period == BudgetPeriod.monthly ? 'Monthly' : 'Weekly';

  // True kung ang petsa ay nasa loob ng budget period
  bool contains(DateTime d) {
    final end = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    return !d.isBefore(startDate) && !d.isAfter(end);
  }
}
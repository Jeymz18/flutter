import '../models/budget.dart';
import '../models/transaction_item.dart';

final Budget sampleBudget = Budget(
  period: BudgetPeriod.monthly,
  amount: 4000,
  startDate: DateTime(2026, 10, 1),
  endDate: DateTime(2026, 10, 31),
);

TransactionItem _exp(String title, double amount, String category, DateTime d) =>
    TransactionItem(
        type: TransactionType.expense,
        title: title,
        amount: amount,
        category: category,
        date: d);

final List<TransactionItem> sampleTransactions = [
  TransactionItem(
      type: TransactionType.income,
      title: 'Allowance',
      amount: 500,
      category: 'Allowance',
      date: DateTime(2026, 10, 5)),
  _exp('Lunch', 120, 'Food', DateTime(2026, 10, 5)),
  _exp('Jeepney Fare', 30, 'Transportation', DateTime(2026, 10, 5)),
  _exp('Milk Tea', 95, 'Personal', DateTime(2026, 10, 4)),
  _exp('Mobile Load', 100, 'Load', DateTime(2026, 10, 4)),
  _exp('Project Materials', 450, 'School Needs', DateTime(2026, 10, 3)),
  _exp('Dinner', 150, 'Food', DateTime(2026, 10, 3)),
  _exp('Tricycle Fare', 60, 'Transportation', DateTime(2026, 10, 2)),
  _exp('Printing', 200, 'School Needs', DateTime(2026, 10, 2)),
  _exp('Birthday Gift', 265, 'Personal', DateTime(2026, 10, 2)),
  _exp('Lunch and Snacks', 380, 'Food', DateTime(2026, 10, 1)),
  _exp('Textbook', 750, 'School Needs', DateTime(2026, 10, 1)),
  _exp('Weekly Fare', 350, 'Transportation', DateTime(2026, 10, 1)),
  _exp('Haircut', 150, 'Personal', DateTime(2026, 10, 1)),
  _exp('Group Project Contribution', 300, 'School Needs', DateTime(2026, 10, 1)),
  TransactionItem(
      type: TransactionType.income,
      title: 'Allowance',
      amount: 4000,
      category: 'Allowance',
      date: DateTime(2026, 10, 1)),
];
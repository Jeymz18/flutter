import 'package:flutter/material.dart';
import '../models/budget.dart';
import '../models/transaction_item.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends StatelessWidget {
  final Budget budget;
  final List<TransactionItem> transactions;

  const HomeScreen({
    super.key,
    required this.budget,
    required this.transactions,
  });

  String get _greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning!';
    if (h < 18) return 'Good afternoon!';
    return 'Good evening!';
  }

  void _comingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Transaction form: next step!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Kunin lang ang transactions na nasa loob ng budget period
    final inPeriod = transactions.where((t) => budget.contains(t.date)).toList();

    final income = inPeriod
        .where((t) => t.type == TransactionType.income)
        .fold<double>(0, (sum, t) => sum + t.amount);
    final expenses = inPeriod
        .where((t) => t.type == TransactionType.expense)
        .fold<double>(0, (sum, t) => sum + t.amount);

    final remaining = budget.amount - expenses;
    final used = budget.amount == 0 ? 0.0 : expenses / budget.amount;
    final percent = (used * 100).round();

    final recent = [...inPeriod]..sort((a, b) => b.date.compareTo(a.date));
    final recentFive = recent.take(5).toList();

    final barColor = used > 1
        ? const Color(0xFFFF8A80)
        : used >= 0.8
            ? const Color(0xFFFFCA28)
            : Colors.white;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_greeting,
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark)),
                      const SizedBox(height: 2),
                      const Text("Let's check your budget",
                          style: TextStyle(color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: AppColors.primary),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Balance card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Remaining Balance',
                      style: TextStyle(color: Colors.white70, fontSize: 14)),
                  const SizedBox(height: 4),
                  Text(peso(remaining),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${budget.periodLabel} Budget  •  ${rangeText(budget.startDate, budget.endDate)}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 18),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: used.clamp(0.0, 1.0).toDouble(),
                      minHeight: 10,
                      backgroundColor: Colors.white24,
                      valueColor: AlwaysStoppedAnimation(barColor),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('$percent% of your budget used',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Summary cards
            Row(
              children: [
                Expanded(
                    child: _SummaryCard(
                        label: 'Budget',
                        amount: budget.amount,
                        icon: Icons.account_balance_wallet,
                        color: const Color(0xFF3B82F6))),
                const SizedBox(width: 10),
                Expanded(
                    child: _SummaryCard(
                        label: 'Income',
                        amount: income,
                        icon: Icons.arrow_upward,
                        color: AppColors.primary)),
                const SizedBox(width: 10),
                Expanded(
                    child: _SummaryCard(
                        label: 'Expenses',
                        amount: expenses,
                        icon: Icons.arrow_downward,
                        color: AppColors.expense)),
              ],
            ),
            const SizedBox(height: 16),

            // Quick actions
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _comingSoon(context),
                    icon: const Icon(Icons.remove_circle_outline),
                    label: const Text('Add Expense'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.expense,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _comingSoon(context),
                    icon: const Icon(Icons.add_circle_outline),
                    label: const Text('Add Income'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Recent transactions
            const Text('Recent Transactions',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: recentFive.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(
                          child: Text('No transactions yet',
                              style: TextStyle(color: AppColors.textMuted))),
                    )
                  : Column(
                      children: recentFive
                          .map((t) => TransactionTile(item: t))
                          .toList(),
                    ),
            ),

            // Warning card
            if (used >= 0.8) ...[
              const SizedBox(height: 16),
              _WarningCard(
                exceeded: used > 1,
                percent: percent,
                periodWord: budget.periodLabel.toLowerCase(),
                overAmount: expenses - budget.amount,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String label;
  final double amount;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 10),
          Text(label,
              style:
                  const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(peso(amount, decimals: false),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark)),
          ),
        ],
      ),
    );
  }
}

class _WarningCard extends StatelessWidget {
  final bool exceeded;
  final int percent;
  final String periodWord;
  final double overAmount;

  const _WarningCard({
    required this.exceeded,
    required this.percent,
    required this.periodWord,
    required this.overAmount,
  });

  @override
  Widget build(BuildContext context) {
    final color = exceeded ? AppColors.expense : AppColors.warning;
    final title =
        exceeded ? 'Budget exceeded' : "You're close to your budget limit";
    final message = exceeded
        ? 'You spent ${peso(overAmount)} more than your planned budget.'
        : 'You have used $percent% of your $periodWord budget.';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.textDark)),
                const SizedBox(height: 4),
                Text(message,
                    style: const TextStyle(color: AppColors.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
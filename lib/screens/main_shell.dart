import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(budget: sampleBudget, transactions: sampleTransactions),
      const _PlaceholderPage('Transactions'),
      const _PlaceholderPage('Summary'),
      const _PlaceholderPage('Settings'),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add Transaction form: next step!')),
          );
        },
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        height: 64,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            _NavItem(Icons.home_rounded, 'Home', _index == 0,
                () => setState(() => _index = 0)),
            _NavItem(Icons.receipt_long_rounded, 'Transactions', _index == 1,
                () => setState(() => _index = 1)),
            const SizedBox(width: 64), // espasyo para sa + button
            _NavItem(Icons.pie_chart_rounded, 'Summary', _index == 2,
                () => setState(() => _index = 2)),
            _NavItem(Icons.settings_rounded, 'Settings', _index == 3,
                () => setState(() => _index = 3)),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem(this.icon, this.label, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textMuted;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    color: color,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text('$title (coming soon)',
            style: const TextStyle(fontSize: 18, color: AppColors.textMuted)),
      ),
    );
  }
}
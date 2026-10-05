const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
];

String peso(double v, {bool decimals = true}) {
  final s = v.toStringAsFixed(decimals ? 2 : 0);
  final parts = s.split('.');
  final whole = parts[0]
      .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
  return decimals ? '₱$whole.${parts[1]}' : '₱$whole';
}

String shortDate(DateTime d) => '${_months[d.month - 1]} ${d.day}, ${d.year}';

String rangeText(DateTime a, DateTime b) =>
    '${_months[a.month - 1]} ${a.day} - ${_months[b.month - 1]} ${b.day}';
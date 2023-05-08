class Expense {
  final double amount;
  final String name;
  final DateTime dateTime;
  final String details;
  final String category;

  Expense({
    required this.amount,
    required this.name,
    required this.dateTime,
    this.details = '',
    this.category = 'Other',
  });
}

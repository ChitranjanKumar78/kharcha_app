class Expenses {
  final double amount;
  final String date;
  final String details;
  final String expenseDate;

  Expenses(
      {required this.amount,
      required this.date,
      required this.details,
      required this.expenseDate});

  Map<String, Object> toMap() {
    return {
      'amount': amount,
      'date': date,
      'details': details,
      'expenseDate': expenseDate
    };
  }

  double get getAmount {
    return amount;
  }

  String get getDate {
    return expenseDate;
  }
}

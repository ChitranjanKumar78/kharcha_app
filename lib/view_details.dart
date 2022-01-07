import 'package:flutter/material.dart';
import 'package:kharcha_app/app_database/app_database.dart';
import 'package:kharcha_app/models/expenses_item.dart';

class ViewDetails extends StatelessWidget {
  final Expenses _expenses;

  const ViewDetails(this._expenses, {Key? key}) : super(key: key);

  String getExpenseDetails() {
    return "Expense Details\n\nAmount: " +
        double.parse(_expenses.amount.toString()).toStringAsFixed(2) +
        "\n\nDate: " +
        _expenses.expenseDate +
        "\n\nComments: " +
        _expenses.details;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getExpenseDetails(),
                style: const TextStyle(fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        AppDatabase.db.deleteExpenseData(_expenses);
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (route) => false);
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

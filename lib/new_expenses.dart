import 'package:flutter/material.dart';
import './app_database/app_database.dart';
import './models/expenses_item.dart';
import 'package:intl/intl.dart';

class NewExpensesScreen extends StatefulWidget {
  const NewExpensesScreen({Key? key}) : super(key: key);

  @override
  _NewExpensesScreenState createState() => _NewExpensesScreenState();
}

class _NewExpensesScreenState extends State<NewExpensesScreen> {
  late String title,
      amount,
      expensesDetails,
      expenseDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        expenseDate = DateFormat('dd/MM/yyyy').format(pickedDate).toString();
      });
    });
  }

  saveExpensesRecord() {
    setState(() {
      amount = amountController.text;
      expensesDetails = descriptionController.text;
    });

    if (amount.isEmpty || expensesDetails.isEmpty) {
      return;
    }

    AppDatabase.db.addNewExpenseData(Expenses(
        amount: double.parse(amount),
        date:
            DateFormat('hh:mm (dd/MM/yyyy)').format(DateTime.now()).toString(),
        details: expensesDetails,
        expenseDate: expenseDate));

    Navigator.pushNamedAndRemoveUntil(context, "/", (routes) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Expenses"),
        elevation: 0,
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Expense Date: " + expenseDate,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(label: Text("Expense Amount!"))),
                TextField(
                    controller: descriptionController,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                        label: Text("Expense comments!"))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: _showDatePicker,
                        child: const Text("Choose Date")),
                    TextButton(
                        onPressed: saveExpensesRecord,
                        child: const Text("Save")),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

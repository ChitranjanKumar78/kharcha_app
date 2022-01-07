import 'package:flutter/material.dart';
import './app_database/app_database.dart';
import './models/expenses_item.dart';
import './view_details.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({Key? key}) : super(key: key);

  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  _getData() async {
    return AppDatabase.db.getDatabaseList();
  }

  void _showBottomSheets(Expenses expenses) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: ViewDetails(expenses),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getData(),
        builder: (context, AsyncSnapshot expensesData) {
          switch (expensesData.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (expensesData.data == null) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    "Start creating expense record!",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: expensesData.data.length,
                    itemBuilder: (context, index) {
                      String amount = expensesData.data[index]["amount"];
                      String date = expensesData.data[index]["date"];
                      String expensesDetails =
                          expensesData.data[index]["details"];
                      String expensesDate =
                          expensesData.data[index]["expenseDate"];

                      Expenses expense = Expenses(
                          amount: double.parse(amount),
                          date: date,
                          details: expensesDetails,
                          expenseDate: expensesDate);

                      return Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Amount: ' +
                                          double.parse(amount.toString())
                                              .toStringAsFixed(2),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      'Date: ' + expensesDate,
                                      maxLines: 1,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      'Comments: ' + expensesDetails,
                                      maxLines: 1,
                                    ),
                                  ],
                                )),
                                IconButton(
                                  onPressed: () {
                                    _showBottomSheets(expense);
                                  },
                                  icon: const Icon(Icons.info_outline),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ));
                    });
              }
            default:
              return const Scaffold();
          }
        });
  }
}

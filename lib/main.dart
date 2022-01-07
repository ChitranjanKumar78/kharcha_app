import 'package:flutter/material.dart';
import './app_database/app_database.dart';
import './expenses_list.dart';
import './new_expenses.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const MyHomePage(title: 'Your Expenses'),
          "NewExpenses": (context) => const NewExpensesScreen()
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert!"),
            content: const Text("Do you want to delete all records!"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
              TextButton(
                  onPressed: () {
                    AppDatabase.db.deleteAllData();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("All records deleted!"),
                      duration: Duration(milliseconds: 500),
                    ));
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: const Text("Yes"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: _showAlertDialog,
              icon: const Icon(Icons.cleaning_services_rounded))
        ],
      ),
      body: const ExpensesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "NewExpenses");
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}

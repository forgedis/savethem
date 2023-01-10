import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);
  static const String routeName = '/expensespage';

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      body: Center(
        child: Text('Expences Screen', style: TextStyle(fontSize: 40, color: Colors.white)),
      ),
    );
  }
}
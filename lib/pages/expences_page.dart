import 'package:flutter/material.dart';

class ExpencesPage extends StatefulWidget {
  const ExpencesPage({Key? key}) : super(key: key);

  @override
  State<ExpencesPage> createState() => _ExpencesPageState();
}

class _ExpencesPageState extends State<ExpencesPage> {
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
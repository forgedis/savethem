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
      appBar: AppBar(title: Text('Expences')),
      body: Center(
        child: Text('Expences Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
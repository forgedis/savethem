import 'package:flutter/material.dart';

class Expences extends StatefulWidget {
  const Expences({Key? key}) : super(key: key);

  @override
  State<Expences> createState() => _ExpencesState();
}

class _ExpencesState extends State<Expences> {
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
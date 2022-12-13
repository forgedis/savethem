import 'package:flutter/material.dart';

class AddReceiptPage extends StatefulWidget {
  const AddReceiptPage({Key? key}) : super(key: key);

  @override
  State<AddReceiptPage> createState() => _AddReceiptPageState();
}

class _AddReceiptPageState extends State<AddReceiptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Receipt')),
      body: Center(
        child: Text('Add Receipt Screen', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
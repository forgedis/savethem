import 'package:flutter/material.dart';

class AddReceipt extends StatefulWidget {
  const AddReceipt({Key? key}) : super(key: key);

  @override
  State<AddReceipt> createState() => _AddReceiptState();
}

class _AddReceiptState extends State<AddReceipt> {
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
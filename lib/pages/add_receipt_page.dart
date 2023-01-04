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
      backgroundColor: Color(0xFF261c51),
      body: Center(
        child: Text('Add Receipt Screen', style: TextStyle(fontSize: 40, color: Colors.white)),
      ),
    );
  }
}
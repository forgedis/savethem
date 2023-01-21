import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';
import 'package:savethem/model/spending.dart';
import 'package:savethem/service/api_service.dart';
import '../main.dart';

class ExpensesPage extends ConsumerStatefulWidget {
  const ExpensesPage({Key? key}) : super(key: key);
  static const String routeName = '/expensespage';

  @override
  ConsumerState<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends ConsumerState<ExpensesPage> {
  List<Spending> _spendings = [];
  final _date1TEC = TextEditingController();
  DateTime _date1 = DateTime.now();
  final _date2TEC = TextEditingController();
  DateTime _date2 = DateTime.now();
  double _month1Price = 0;
  double _month2Price = 0;
  double _finalPrice = 0;
  bool _visible = false;
  String _differanceValue = '';
  Color _textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF261c51),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text('Comapare months',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25))),
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('First month',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
              ),
              const SizedBox(height: 5),
              TextField(
                readOnly: true,
                controller: _date1TEC,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showMonthPicker(
                              context: context,
                              initialDate: _date1,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (context, child) => Theme(
                                    data: ThemeData().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Color(0xFFae91f9),
                                          onPrimary: Color(0xFF261c51),
                                          surface: Color(0xFF261c51),
                                          onSurface: Color(0xFFf1cb46)),
                                    ),
                                    child: child!,
                                  ));

                          if (newDate == null) return;

                          setState(() => _date1 = newDate);

                          final formattedDate =
                              DateFormat('MMMM y').format(_date1);
                          _date1TEC.text = formattedDate;
                        },
                        icon: const Icon(Icons.calendar_month,
                            color: Colors.white))),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text('Second month',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
              ),
              const SizedBox(height: 5),
              TextField(
                readOnly: true,
                controller: _date2TEC,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showMonthPicker(
                              context: context,
                              initialDate: _date2,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (context, child) => Theme(
                                    data: ThemeData().copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Color(0xFFae91f9),
                                          onPrimary: Color(0xFF261c51),
                                          surface: Color(0xFF261c51),
                                          onSurface: Color(0xFFf1cb46)),
                                    ),
                                    child: child!,
                                  ));

                          if (newDate == null) return;

                          setState(() => _date2 = newDate);

                          final formattedDate =
                              DateFormat('MMMM y').format(_date2);
                          _date2TEC.text = formattedDate;
                        },
                        icon: const Icon(Icons.calendar_month,
                            color: Colors.white))),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () async {
                      double price1 = 0;
                      double price2 = 0;

                      final user =
                          await ref.read(appwriteAccountProvider).get();
                      _spendings = await ApiService.instance
                          .getSpending(userId: user.$id);

                      _spendings.forEach((element) {
                        if (element.date.month == _date1.month) {
                          price1 += element.price;
                        }
                      });

                      _spendings.forEach((element) {
                        if (element.date.month == _date2.month) {
                          price2 += element.price;
                        }
                      });

                      if (price1 > price2) {
                        setState(() {
                          _differanceValue = 'less';
                          _textColor = Colors.green;
                        });
                      } else if (price1 < price2) {
                        setState(() {
                          _differanceValue = 'more';
                          _textColor = Colors.red;
                        });
                      }

                      setState(() {
                        _month1Price = price1;
                        _visible = true;
                        _month2Price = price2;
                        _finalPrice = _month2Price - _month1Price;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF8a5bf5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: const Text(
                      "Compare",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Visibility(
                visible: _visible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _date1TEC.text + ' : ',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      _month1Price.toString() + ' DKK',
                      style: const TextStyle(
                          color: Color(0xFFf1cb46),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: _visible,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _date2TEC.text + ' : ',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      _month2Price.toString() + ' DKK',
                      style: const TextStyle(
                          color: Color(0xFFf1cb46),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Visibility(
                  visible: _visible,
                  child: Center(
                    child: RichText(
                        textAlign: TextAlign.center,
                        text:
                            TextSpan(style: const TextStyle(color: Colors.blue),
                                //apply style to all
                                children: [
                              TextSpan(
                                  text: 'In ' +
                                      _date2TEC.text +
                                      ' you spent \n\n',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                              TextSpan(
                                  text: _finalPrice.abs().toString() + ' DKK ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: _textColor)),
                              TextSpan(
                                  text: _differanceValue + '\n\n',
                                  style: TextStyle(
                                      color: _textColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              TextSpan(
                                  text: 'than in ' + _date1TEC.text,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17))
                            ])),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
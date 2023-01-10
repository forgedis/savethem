import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_chart/pie_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, double> dataMap = {
    "Food": 5,
    "Car": 3,
    "Housing": 2,
    "Free time": 2,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Text(
                'Expenses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
              Container(
                padding: EdgeInsets.all(35),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 1000),
                  ringStrokeWidth: 10,
                  legendOptions: LegendOptions(
                      legendPosition: LegendPosition.bottom,
                      legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  chartType: ChartType.ring,
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: false,
                    showChartValues: false,
                    decimalPlaces: 1,
                  ),
                  centerText: '24000 dkk',
                  centerTextStyle: TextStyle(
                      color: Color(0xFFf1cb46),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
      // child: Text('Homepage Screen', style: TextStyle(fontSize: 40, color: Colors.white)),
    );
  }
}

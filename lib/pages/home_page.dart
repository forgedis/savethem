import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import '../service/api_service.dart';
import '../main.dart';
import '../model/category.dart';
import '../model/spending.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homepage';

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final _user;
  List<Spending> _spendings = [];
  List<Category> _categories = [];
  bool _isLoading = false;
  double _totalPrice = 0;
  Map<String, double> _dataMap = {};
  Map<dynamic, double> _usedCategoryDataMap = {};

  void fetchData() async {
    setState(() => _isLoading = true);

    _user = await ref.read(appwriteAccountProvider).get();
    _spendings = await ApiService.instance.getSpending(userId: _user.$id);
    await Future.forEach(_spendings, (element) async {
      var category = await ApiService.instance
          .getCategoryById(categoryId: element.categoryId);
      _categories.add(await ApiService.instance
          .getCategoryById(categoryId: element.categoryId));
      _usedCategoryDataMap[category] = element.price;
    });

    setState(() {
      Map<String, double> tempMap = _usedCategoryDataMap.map((key, value) {
        return MapEntry(key.name, value);
      });
      _dataMap = tempMap;

      for (var element in _spendings) {
        _totalPrice += element.price;
      }
    });

    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF261c51),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading) ...[
                  const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 50.0,
                  )
                ],
                if (!_isLoading) ...[
                  Text(
                    'Welcome back \n' + _user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(35),
                    child: PieChart(
                      dataMap: _dataMap,
                      animationDuration: const Duration(milliseconds: 1000),
                      ringStrokeWidth: 10,
                      legendOptions: const LegendOptions(
                          legendPosition: LegendPosition.bottom,
                          legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      chartType: ChartType.ring,
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: false,
                        decimalPlaces: 1,
                      ),
                      centerText: '$_totalPrice DKK',
                      centerTextStyle: const TextStyle(
                          color: Color(0xFFf1cb46),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:savethem/service/api_service.dart';
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
  void fetchData() async {
    setState(() => isLoading = true);

    user = await ref.read(appwriteAccountProvider).get();
    spendings = await ApiService.instance.getSpending(userID: user.$id);

    setState(() {
      dataMap = Map.fromIterable(spendings,
          key: (e) => e.categoryID, value: (e) => e.price);

      for (var element in spendings) {
        totalPrice += element.price;
      }
      //
      // var categoryList = dataMap.keys.toList();
      //
      // List<Category> list = [];
      //
      // categoryList.forEach((element) async{
      //   list.add(await ApiService.instance.getCategoryByID(categoryID: element));
      //
      //   list.forEach((element) {
      //     print(element.name);
      //   });
      //   // print(element);
      // });
      //
      // finalDataMap = Map.fromIterable(list,
      //     key: (e) => e.name, value: (e) => e.price);
    });



    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  late final user;
  List<Spending> spendings = [];
  bool isLoading = false;
  double totalPrice = 0;
  Map<String, double> dataMap = {};
  Map<String, double> finalDataMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) ...[
                SpinKitThreeBounce(
                  color: Colors.white,
                  size: 50.0,
                )
              ],
              if (!isLoading) ...[
                Text(
                  'Welcome back \n' + user.name,
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
                    centerText: totalPrice.toString() + ' DKK',
                    centerTextStyle: TextStyle(
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
      // child: Text('Homepage Screen', style: TextStyle(fontSize: 40, color: Colors.white)),
    );
  }
}

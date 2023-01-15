import 'package:flutter/material.dart';
import 'pages/add_page.dart';
import 'pages/expenses_page.dart';
import 'pages/home_page.dart';
import 'pages/category_page.dart';
import 'pages/profile_page.dart';

class AppTree extends StatefulWidget {
  const AppTree({Key? key}) : super(key: key);
  static const String routeName = '/app_tree';

  @override
  State<AppTree> createState() => _AppTreeState();
}

class _AppTreeState extends State<AppTree> {
  int _currentTab = 0;

  // final List<Widget> screens = [
  //   HomePage(),
  //   CategoryPage(),
  //   ProfilePage(),
  //   ExpensesPage(),
  //   AddPage()
  // ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomePage();

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: const Color(0xFF261c51),
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFFf1cb46),
          onPressed: () {
            setState(() {
              currentScreen = const AddPage();
              _currentTab = 4;
            });
          },
          child: const Icon(Icons.add, color: Colors.black),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF8a5bf5),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Left side of bottom bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const HomePage();
                        _currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: _currentTab == 0
                              ? const Color(0xFFf1cb46)
                              : Colors.black,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: _currentTab == 0
                                  ? const Color(0xFFf1cb46)
                                  : Colors.black),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ExpensesPage();
                        _currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.euro,
                          color: _currentTab == 1
                              ? const Color(0xFFf1cb46)
                              : Colors.black,
                        ),
                        Text(
                          'Expences',
                          style: TextStyle(
                              color: _currentTab == 1
                                  ? const Color(0xFFf1cb46)
                                  : Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              //Right side of bottom bar
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const CategoryPage();
                        _currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.list,
                          color: _currentTab == 2
                              ? const Color(0xFFf1cb46)
                              : Colors.black,
                        ),
                        Text(
                          'Categories',
                          style: TextStyle(
                              color: _currentTab == 2
                                  ? const Color(0xFFf1cb46)
                                  : Colors.black),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ProfilePage();
                        _currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: _currentTab == 3
                              ? const Color(0xFFf1cb46)
                              : Colors.black,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: _currentTab == 3
                                  ? const Color(0xFFf1cb46)
                                  : Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

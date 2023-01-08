import 'package:flutter/material.dart';
import 'package:savethem/pages/add_page.dart';
import 'package:savethem/pages/expences_page.dart';
import 'package:savethem/pages/home_page.dart';
import 'package:savethem/pages/profile_page.dart';
import 'package:savethem/pages/settings_page.dart';

class AppTree extends StatefulWidget {
  const AppTree({Key? key}) : super(key: key);
  static const String routeName = '/app_tree';

  @override
  State<AppTree> createState() => _AppTreeState();
}

class _AppTreeState extends State<AppTree> {
  int currentTab = 0;
  final List<Widget> screens = [
    HomePage(),
    ProfilePage(),
    SettingsPage(),
    ExpencesPage(),
    AddPage()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      body: PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: Color(0xFFf1cb46),
        onPressed: () {
          setState(() {
            currentScreen = AddPage();
            currentTab = 4;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Color(0xFF8a5bf5),
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
                        currentScreen = HomePage();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Color(0xFFf1cb46) : Colors.black,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Color(0xFFf1cb46) : Colors.black),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = ExpencesPage();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.euro,
                          color: currentTab == 1 ? Color(0xFFf1cb46) : Colors.black,
                        ),
                        Text(
                          'Expences',
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Color(0xFFf1cb46) : Colors.black),
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
                        currentScreen = ProfilePage();
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: currentTab == 2 ? Color(0xFFf1cb46) : Colors.black,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color:
                                  currentTab == 2 ? Color(0xFFf1cb46) : Colors.black),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = SettingsPage();
                        currentTab = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTab == 3 ? Color(0xFFf1cb46) : Colors.black,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                              color:
                                  currentTab == 3 ? Color(0xFFf1cb46) : Colors.black),
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

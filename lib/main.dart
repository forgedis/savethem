import 'package:flutter/material.dart';
import 'package:savethem/app_tree.dart';
import 'package:savethem/pages/login_or_signup_page.dart';
import 'package:savethem/pages/login_page.dart';
import 'package:savethem/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute<void>(
          builder: (context) {
            switch (routeSettings.name) {
              case LoginPage.routeName:
                return const LoginPage();
              case SignupPage.routeName:
                return const SignupPage();
              case AppTree.routeName:
                return AppTree();
              default:
                return const LoginOrSignupPage();
            }
          },
        );
      },
    );
  }
}

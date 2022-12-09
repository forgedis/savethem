import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:savethem/core/presentation/notifiers/providers.dart';
import 'package:savethem/pages/login.dart';
import 'package:savethem/pages/signup.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Signup(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


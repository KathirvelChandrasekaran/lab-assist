import 'package:flutter/material.dart';
import 'package:lab_assist/screens/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primarySwatch: Colors.red,
          primaryColor: Color(0xffD64550),
          hintColor: Colors.white,
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.black,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color(0xffD64550),
          )),
    );
  }
}

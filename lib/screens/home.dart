import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:lab_assist/screens/createRequest.dart';
import 'package:lab_assist/screens/profile.dart';
import 'package:lab_assist/screens/requestHistory.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String userName;
  Home({this.userName});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static String uName;

  @override
  void initState() {
    super.initState();
    uName = widget.userName;
  }

  int currentIndex = 0;
  List screensList = [
    CreateRequest(
      userName: uName,
    ),
    RequestHistory(
      userName: uName,
    ),
    Profile(
      userName: uName,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screensList[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        animationDuration: Duration(milliseconds: 250),
        selectedIndex: currentIndex,
        backgroundColor: Colors.black,
        showElevation: false,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        curve: Curves.easeInOutSine,
        items: [
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(
              Icons.add_to_queue_outlined,
              color: Color(0xffD64550),
              size: 30,
            ),
            title: Text(
              'New',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Color(0xffD64550),
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(
              Icons.receipt_outlined,
              size: 30,
              color: Color(0xffD64550),
            ),
            title: Text(
              'Requests',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Color(0xffD64550),
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(
              Icons.person,
              size: 30,
              color: Color(0xffD64550),
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Color(0xffD64550),
          ),
        ],
      ),
    );
  }
}

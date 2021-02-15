import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:lab_assist/screens/addStudent.dart';
import 'package:lab_assist/screens/requests.dart';
import 'package:lab_assist/screens/viewStudents.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  int currentIndex = 0;
  List screensList = [Requests(), ViewStudents(), AddStudent()];
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
              Icons.receipt_long_outlined,
              color: Color(0xffD64550),
              size: 30,
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
              Icons.person_search_rounded,
              size: 30,
              color: Color(0xffD64550),
            ),
            title: Text(
              'View Users',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Color(0xffD64550),
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: Icon(
              Icons.add_circle_outline_rounded,
              size: 30,
              color: Color(0xffD64550),
            ),
            title: Text(
              'Add User',
              style: TextStyle(color: Colors.white),
            ),
            activeColor: Color(0xffD64550),
          ),
        ],
      ),
    );
  }
}

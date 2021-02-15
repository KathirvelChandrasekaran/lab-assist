import 'package:flutter/material.dart';

import 'package:lab_assist/screens/login.dart';
import 'package:lab_assist/widgets/hardwareRequestWidget.dart';
import 'package:lab_assist/widgets/softwareRequestWidget.dart';
import 'package:lab_assist/widgets/remoteAccessWidget.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Requests".toUpperCase(),
          style: TextStyle(letterSpacing: 2, color: Color(0xffD64550)),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
            tooltip: "Logout",
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Hardware Requests".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            hardwareDetails("", context, true),
            Text(
              "Software Requests".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            softwareDetails("", context, true),
            Text(
              "Remote Access Requests".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            remoteAccessDetails("", context, true),
          ],
        ),
      ),
    );
  }
}

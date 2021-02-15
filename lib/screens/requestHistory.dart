import 'package:flutter/material.dart';
import 'package:lab_assist/screens/login.dart';
import 'package:lab_assist/screens/userHistory.dart';
import 'package:lab_assist/widgets/hardwareRequestWidget.dart';
import 'package:lab_assist/widgets/remoteAccessWidget.dart';
import 'package:lab_assist/widgets/softwareRequestWidget.dart';

// ignore: must_be_immutable
class RequestHistory extends StatefulWidget {
  String userName;
  RequestHistory({this.userName});
  @override
  _RequestHistoryState createState() => _RequestHistoryState();
}

class _RequestHistoryState extends State<RequestHistory> {
  static String uName;

  @override
  void initState() {
    super.initState();
    uName = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pending Request".toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
            color: Color(0xffD64550),
            fontWeight: FontWeight.bold,
          ),
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
            icon: Icon(Icons.logout),
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
            hardwareDetails(uName, context, false),
            Text(
              "Software Requests".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            softwareDetails(uName, context, false),
            Text(
              "Remote Access Requests".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            remoteAccessDetails(uName, context, false),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.history_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserHistory(
                userName: uName,
              ),
            ),
          );
        },
      ),
    );
  }
}

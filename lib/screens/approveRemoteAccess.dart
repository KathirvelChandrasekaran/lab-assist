import 'package:flutter/material.dart';

class ApproveRemoteAcess extends StatefulWidget {
  @override
  _ApproveRemoteAcessState createState() => _ApproveRemoteAcessState();
}

class _ApproveRemoteAcessState extends State<ApproveRemoteAcess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Approve Remote Access".toUpperCase(),
          style: TextStyle(letterSpacing: 2, color: Color(0xffD64550)),
        ),
      ),
    );
  }
}

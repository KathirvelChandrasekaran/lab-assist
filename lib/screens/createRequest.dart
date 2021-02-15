import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:lab_assist/screens/login.dart';
import 'package:lab_assist/screens/requests/hardwareRequests.dart';
import 'package:lab_assist/screens/requests/remoteAccessRequest.dart';
import 'package:lab_assist/screens/requests/softwareRequest.dart';

// ignore: must_be_immutable
class CreateRequest extends StatefulWidget {
  String userName;
  CreateRequest({this.userName});
  @override
  _CreateRequestState createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  final String assetName1 = 'images/hardware.svg';
  final String assetName2 = 'images/software.svg';
  final String assetName3 = 'images/remote.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Request".toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
            color: Color(0xffD64550),
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
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.20,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SvgPicture.asset(
                    assetName1,
                    width: MediaQuery.of(context).size.width * 0.50,
                    placeholderBuilder: (context) => Icon(Icons.error),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.50,
                    height: 50.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: RaisedButton(
                      elevation: 5,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HardwareRequest(
                              userName: widget.userName,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Hardware".toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD64550),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.20,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SvgPicture.asset(
                    assetName2,
                    width: MediaQuery.of(context).size.width * 0.50,
                    placeholderBuilder: (context) => Icon(Icons.error),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.50,
                    height: 50.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 5,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SoftwareRequest(
                              userName: widget.userName,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Software".toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD64550),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.20,
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SvgPicture.asset(
                    assetName3,
                    width: MediaQuery.of(context).size.width * 0.50,
                    placeholderBuilder: (context) => Icon(Icons.error),
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.15),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width * 0.50,
                    height: 50.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: RaisedButton(
                      color: Colors.white,
                      elevation: 5,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RemoteAccessRequest(
                              userName: widget.userName,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        "Remote Access".toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD64550),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

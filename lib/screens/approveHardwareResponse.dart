import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_assist/services/roleAuth.dart';

// ignore: must_be_immutable
class HardwareResponse extends StatefulWidget {
  String pcID, item1, item2, item3, item4, item5, request, userName;
  DocumentSnapshot documentSnapshot;
  HardwareResponse(
      {this.pcID,
      this.item1,
      this.item2,
      this.item3,
      this.item4,
      this.item5,
      this.request,
      this.userName,
      this.documentSnapshot});
  @override
  _HardwareResponseState createState() => _HardwareResponseState();
}

class _HardwareResponseState extends State<HardwareResponse> {
  final String assetName1 = 'images/done.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hardware Response".toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
            color: Color(0xffD64550),
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SvgPicture.asset(
                    assetName1,
                    width: MediaQuery.of(context).size.width * 0.8,
                    placeholderBuilder: (context) => Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.80,
                height: 50.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: RaisedButton(
                  color: Color(0xffD64550),
                  onPressed: () async {
                    completedHardware(
                        widget.pcID,
                        widget.item1,
                        widget.item2,
                        widget.item3,
                        widget.item4,
                        widget.item5,
                        widget.request,
                        widget.userName,
                        widget.documentSnapshot,
                        context);
                  },
                  child: Text(
                    "Mark as completed".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

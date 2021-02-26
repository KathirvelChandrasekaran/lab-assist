import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_assist/screens/approveHardwareResponse.dart';

// ignore: must_be_immutable
class ViewHardware extends StatefulWidget {
  String pcID, item1, item2, item3, item4, item5, request, userName;
  DocumentSnapshot documentSnapshot;
  ViewHardware(
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
  _ViewHardwareState createState() => _ViewHardwareState();
}

class _ViewHardwareState extends State<ViewHardware> {
  final String assetName1 = 'images/details.svg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Details".toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: SvgPicture.asset(
                assetName1,
                width: MediaQuery.of(context).size.width * 0.7,
                placeholderBuilder: (context) => Icon(Icons.error),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              margin: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.80,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.computer_rounded,
                        color: Color(0xffD64550),
                      ),
                      title: Text(
                        widget.pcID,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        widget.request,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.category_rounded,
                        color: Color(0xffD64550),
                      ),
                      title: Text(
                        'Items',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.item1,
                        ),
                        Text(
                          widget.item2,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          widget.item3,
                        ),
                        Text(
                          widget.item4,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          widget.item5,
                        ),
                      ],
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width * 0.50,
                      height: 50.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: RaisedButton(
                        color: Color(0xffD64550),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HardwareResponse(
                                pcID: widget.pcID,
                                item1: widget.item1,
                                item2: widget.item2,
                                item3: widget.item3,
                                item4: widget.item4,
                                item5: widget.item5,
                                request: widget.request,
                                documentSnapshot: widget.documentSnapshot,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "Approve".toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class AcceptedRemote extends StatefulWidget {
  String userName;
  AcceptedRemote({this.userName});
  @override
  _AcceptedRemoteState createState() => _AcceptedRemoteState();
}

class _AcceptedRemoteState extends State<AcceptedRemote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Remote Credentitals".toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
            color: Color(0xffD64550),
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('RemoteAccessResponse')
                .where('userName', isEqualTo: widget.userName)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: Container(
                    child: SpinKitWave(
                      color: Color(0xffD64550),
                    ),
                  ),
                );
              else
                return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot response = snapshot.data.docs[index];
                    return Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: MediaQuery.of(context).size.height * 0.20,
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(
                                Icons.computer_rounded,
                                color: Color(0xffD64550),
                              ),
                              Text(
                                response['pcID'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.vpn_key_outlined,
                                color: Color(0xffD64550),
                              ),
                              Text(
                                response['password'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
            },
          ),
        ),
      ),
    );
  }
}

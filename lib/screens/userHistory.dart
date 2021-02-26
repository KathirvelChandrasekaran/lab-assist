import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class UserHistory extends StatefulWidget {
  String userName;
  UserHistory({this.userName});
  @override
  _UserHistoryState createState() => _UserHistoryState();
}

class _UserHistoryState extends State<UserHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "History".toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
            color: Color(0xffD64550),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('History')
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
                                height: 10,
                              ),
                              Icon(
                                Icons.category_rounded,
                                color: Color(0xffD64550),
                              ),
                              Text(
                                response['request'].toString().toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(
                                Icons.comment_rounded,
                                color: Color(0xffD64550),
                              ),
                              Text(
                                response['reason'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Icon(
                                Icons.calendar_today_outlined,
                                color: Color(0xffD64550),
                              ),
                              Text(
                                response['finishedAt']
                                    .toDate()
                                    .toString()
                                    .substring(0, 10),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
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

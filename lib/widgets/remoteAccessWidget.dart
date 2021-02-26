import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab_assist/screens/remoteResponse.dart';

Widget remoteAccessDetails(String userName, BuildContext context, bool role) {
  return SingleChildScrollView(
    child: Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: StreamBuilder(
        stream: role == false
            ? FirebaseFirestore.instance
                .collection('RemoteAccess')
                .where('userName', isEqualTo: userName)
                .snapshots()
            : FirebaseFirestore.instance.collection('RemoteAccess').snapshots(),
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
              itemBuilder: (conetxt, index) {
                DocumentSnapshot requests = snapshot.data.docs[index];
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
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
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.person,
                                color: Color(0xffD64550),
                              ),
                              Text(
                                requests['userName'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Icon(
                                Icons.comment_outlined,
                                color: Color(0xffD64550),
                              ),
                              Text(
                                requests['reason'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    role == true
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: Color(0xffD64550),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                requests['createdAt']
                                                    .toDate()
                                                    .toString()
                                                    .substring(0, 10),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.send_outlined),
                                                onPressed: () {
                                                  DocumentSnapshot snapshot =
                                                      requests;
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          RemoteResponse(
                                                        userName: requests[
                                                            'userName'],
                                                        dateTime: requests[
                                                                'createdAt']
                                                            .toDate(),
                                                        request:
                                                            requests['reason'],
                                                        documentSnapshot:
                                                            snapshot,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                color: Color(0xffD64550),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.date_range,
                                                color: Color(0xffD64550),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                requests['createdAt']
                                                    .toDate()
                                                    .toString()
                                                    .substring(0, 10),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
        },
      ),
    ),
  );
}

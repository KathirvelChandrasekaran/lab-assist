import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab_assist/screens/viewSoftware.dart';

Widget softwareDetails(String userName, BuildContext context, bool role) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.25,
    child: StreamBuilder(
      stream: role == false
          ? FirebaseFirestore.instance
              .collection('SoftwareRequests')
              .where('requestedBy', isEqualTo: userName)
              .snapshots()
          : FirebaseFirestore.instance
              .collection('SoftwareRequests')
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
                              Icons.computer,
                              color: Color(0xffD64550),
                            ),
                            Text(
                              requests['PCID'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Icon(
                              Icons.devices_rounded,
                              color: Color(0xffD64550),
                            ),
                            Center(
                              child: Text(
                                requests['items']['item1'] +
                                    " " +
                                    requests['items']['item2'] +
                                    " " +
                                    requests['items']['item3'] +
                                    " " +
                                    requests['items']['item4'] +
                                    " " +
                                    requests['items']['item5'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  role == true
                                      ? IconButton(
                                          icon: Icon(Icons.send_outlined),
                                          onPressed: () {
                                            DocumentSnapshot snapshot =
                                                requests;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewSoftware(
                                                  pcID: requests['PCID'],
                                                  item1: requests['items']
                                                      ['item1'],
                                                  item2: requests['items']
                                                      ['item2'],
                                                  item3: requests['items']
                                                      ['item3'],
                                                  item4: requests['items']
                                                      ['item4'],
                                                  item5: requests['items']
                                                      ['item5'],
                                                  request: requests['request'],
                                                  userName:
                                                      requests['requestedBy'],
                                                  documentSnapshot: snapshot,
                                                  software:
                                                      requests['software'],
                                                ),
                                              ),
                                            );
                                          },
                                          color: Color(0xffD64550),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.comment_outlined,
                                              color: Color(0xffD64550),
                                            ),
                                            Text(
                                              requests['request'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          );
      },
    ),
  );
}

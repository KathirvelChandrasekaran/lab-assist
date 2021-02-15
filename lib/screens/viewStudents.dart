import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab_assist/screens/login.dart';

class ViewStudents extends StatefulWidget {
  @override
  _ViewStudentsState createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View All".toUpperCase(),
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
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .orderBy('userName')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: Container(
                child: SpinKitWave(
                  color: Color(0xffD64550),
                ),
              ));
            else
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (conetxt, index) {
                  DocumentSnapshot users = snapshot.data.docs[index];
                  return Center(
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          elevation: 8,
                          color: Colors.white,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            height: MediaQuery.of(context).size.height * 0.08,
                            child: Center(
                              child: Text(
                                users['userName'],
                                style: TextStyle(
                                  color: Color(0xffD64550),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        )
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
}

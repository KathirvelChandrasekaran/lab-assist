import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab_assist/services/adminService.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password".toUpperCase(),
          style: TextStyle(
            letterSpacing: 2,
          ),
        ),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('PasswordRequests')
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
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  users['userName'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                IconButton(
                                    icon: Icon(Icons.done_outline_outlined),
                                    color: Color(0xffD64550),
                                    onPressed: () {
                                      resetPassword(users['userName'], users);
                                    })
                              ],
                            )),
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

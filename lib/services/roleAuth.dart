import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crypt/crypt.dart';

import 'package:lab_assist/screens/adminPanel.dart';
import 'package:lab_assist/screens/home.dart';

Future<String> authentication(
    String userName, String password, String role, BuildContext context) async {
  String returnVal = '';
  try {
    await FirebaseFirestore.instance
        .collection("Users")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        if (role == 'admin') {
          if (role == result.data()['role']) {
            if (Crypt(result.data()['password']).match(password))
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminPanel(),
                ),
              );
          } else
            returnVal = "* Wrong credentials.";
        } else if (role == 'student') {
          if (role == result.data()['role']) {
            if (Crypt(result.data()['password']).match(password))
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Home(
                          userName: userName,
                        )),
              );
          } else
            returnVal = "* Wrong credentials.";
        } else
          returnVal = "* Wrong credentials.";
      });
    });
    return returnVal;
  } catch (e) {
    print(e);
  }
}

updatePassword(String userName, String newPassword) {
  FirebaseFirestore.instance
      .collection('Users')
      .where('userName', isEqualTo: userName)
      .get()
      .then((value) => FirebaseFirestore.instance
          .collection('Users')
          .doc(value.docs.first.id)
          .update({'password': Crypt.sha256(newPassword).toString()}));
}

grantRemoteAccess(
    String userName,
    String request,
    DateTime dateTime,
    String pcID,
    String password,
    BuildContext context,
    DocumentSnapshot documentSnapshot) {
  FirebaseFirestore.instance
      .collection('RemoteAccessResponse')
      .add({
        'userName': userName,
        'request': request,
        'requestedAt': dateTime,
        'pcID': pcID,
        'password': password,
        'createdAt': DateTime.now().toLocal()
      })
      .then((value) => FirebaseFirestore.instance.collection('History').add({
            'createdAt': documentSnapshot['createdAt'],
            'reason': documentSnapshot['reason'],
            'userName': documentSnapshot['userName'],
            'request': 'remote',
            'finishedAt': DateTime.now()
          }))
      .then((value) => FirebaseFirestore.instance
          .collection('RemoteAccess')
          .doc(documentSnapshot.id)
          .delete()
          .then((value) => print('Success'))
          .catchError((error) => print("Failed to delete user: $error")));
  Navigator.pop(context);
}

completedHardware(
    String pcID,
    String item1,
    String item2,
    String item3,
    String item4,
    String item5,
    String request,
    String userName,
    DocumentSnapshot documentSnapshot,
    BuildContext context) {
  FirebaseFirestore.instance
      .collection('HardwareResponse')
      .add({
        'userName': userName,
        'request': request,
        'pcID': pcID,
        'items': {
          'item1': item1,
          'item2': item2,
          'item3': item3,
          'item4': item4,
          'item5': item5,
        },
        'createdAt': DateTime.now().toLocal()
      })
      .then((value) => FirebaseFirestore.instance.collection('History').add({
            'reason': documentSnapshot['request'],
            'userName': documentSnapshot['requestedBy'],
            'request': 'hardware',
            'finishedAt': DateTime.now()
          }))
      .then((value) => FirebaseFirestore.instance
          .collection('HardwareRequests')
          .doc(documentSnapshot.id)
          .delete()
          .then((value) => print('Success'))
          .catchError((error) => print("Failed to delete user: $error")));
  Navigator.pop(context);
}

completedSoftware(
    String pcID,
    String item1,
    String item2,
    String item3,
    String item4,
    String item5,
    String request,
    String userName,
    String software,
    DocumentSnapshot documentSnapshot,
    BuildContext context) {
  FirebaseFirestore.instance
      .collection('SoftwareResponse')
      .add({
        'userName': userName,
        'request': request,
        'pcID': pcID,
        'items': {
          'item1': item1,
          'item2': item2,
          'item3': item3,
          'item4': item4,
          'item5': item5,
        },
        'createdAt': DateTime.now().toLocal(),
        'software': software
      })
      .then((value) => FirebaseFirestore.instance.collection('History').add({
            'reason': documentSnapshot['request'],
            'userName': documentSnapshot['requestedBy'],
            'request': 'software',
            'finishedAt': DateTime.now()
          }))
      .then((value) => FirebaseFirestore.instance
          .collection('SoftwareRequests')
          .doc(documentSnapshot.id)
          .delete()
          .then((value) => print('Success'))
          .catchError((error) => print("Failed to delete user: $error")));
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => AdminPanel(),
    ),
  );
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:lab_assist/screens/adminPanel.dart';

Future<String> addStudent(
    String userName, String password, BuildContext context) async {
  String encryptedPassword = Crypt.sha256(password).toString();
  var result = await FirebaseFirestore.instance
      .collection("Users")
      .where('userName', isEqualTo: userName)
      .get();
  if (result.docs.isEmpty) {
    FirebaseFirestore.instance.collection('Users').add({
      'userName': userName,
      'role': 'student',
      'password': encryptedPassword
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminPanel(),
      ),
    );
    return "";
  } else
    return "* Student already exists";
}

reqNewPassword(String userName, BuildContext context) {
  FirebaseFirestore.instance.collection('PasswordRequests').add({
    'userName': userName.toUpperCase(),
    'requestedAt': DateTime.now()
  }).then((value) => Navigator.pop(context));
}

resetPassword(String userName, DocumentSnapshot snapshot) {
  FirebaseFirestore.instance
      .collection('Users')
      .where('userName', isEqualTo: userName)
      .get()
      .then((value) => FirebaseFirestore.instance
          .collection('Users')
          .doc(value.docs.first.id)
          .update({'password': Crypt.sha256('password').toString()}))
      .then((value) => FirebaseFirestore.instance.collection('History').add({
            'createdAt': DateTime.now(),
            'reason': 'password',
            'userName': userName,
            'request': 'password',
            'finishedAt': DateTime.now()
          }))
      .then((value) => FirebaseFirestore.instance
          .collection('PasswordRequests')
          .doc(snapshot.id)
          .delete()
          .then((value) => print('Success'))
          .catchError((error) => print("Failed to delete user: $error")));
}

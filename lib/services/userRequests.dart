import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

addHardwareRequest(bool monitor, bool mouse, bool keyboard, bool cpu, bool lan,
    String request, String userName, String pcName, BuildContext context) {
  String monitor_1 = "", mouse_1 = "", keyboard_1 = "", cpu_1 = "", lan_1 = "";
  if (monitor == true) monitor_1 = "Monitor";
  if (mouse == true) mouse_1 = "Mouse";
  if (keyboard == true) keyboard_1 = "Keyboard";
  if (cpu == true) cpu_1 = "CPU";
  if (lan == true) lan_1 = "LAN";

  FirebaseFirestore.instance.collection('HardwareRequests').add({
    'items': {
      'item1': monitor_1,
      'item2': mouse_1,
      'item3': keyboard_1,
      'item4': cpu_1,
      'item5': lan_1
    },
    'request': request,
    'PCID': pcName,
    'requestedBy': userName
  });
  Navigator.pop(context);
}

addSoftwareRequest(
    bool admin,
    bool installNew,
    bool os,
    bool bootup,
    bool login,
    String softName,
    String request,
    String userName,
    String pcName,
    BuildContext context) {
  String admin_1 = "",
      installNew_1 = "",
      os_1 = "",
      bootup_1 = "",
      login_1 = "";
  if (admin == true) admin_1 = "Admin Rights";
  if (installNew == true) installNew_1 = "Install New";
  if (os == true) os_1 = "OS";
  if (bootup == true) bootup_1 = "Bootup";
  if (login == true) login_1 = "Login";

  FirebaseFirestore.instance.collection('SoftwareRequests').add({
    'items': {
      'item1': admin_1,
      'item2': installNew_1,
      'item3': os_1,
      'item4': bootup_1,
      'item5': login_1,
    },
    'software': softName,
    'request': request,
    'PCID': pcName,
    'requestedBy': userName
  });
  Navigator.pop(context);
}

addRemoteAccess(
    String reason, String userName, DateTime dateTime, BuildContext context) {
  FirebaseFirestore.instance.collection('RemoteAccess').add({
    'reason': reason,
    'userName': userName,
    'createdAt': dateTime.toLocal()
  });
  Navigator.pop(context);
}

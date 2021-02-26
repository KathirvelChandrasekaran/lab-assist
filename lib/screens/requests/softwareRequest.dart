import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lab_assist/services/userRequests.dart';

// ignore: must_be_immutable
class SoftwareRequest extends StatefulWidget {
  String userName;
  SoftwareRequest({this.userName});
  @override
  _SoftwareRequestState createState() => _SoftwareRequestState();
}

class _SoftwareRequestState extends State<SoftwareRequest> {
  final _formKey = GlobalKey<FormState>();
  bool installNew = false,
      admin = false,
      os = false,
      bootup = false,
      login = false;
  TextEditingController _pcNameController = TextEditingController();
  TextEditingController _softwareReqController = TextEditingController();
  TextEditingController _softwareController = TextEditingController();
  String error = "", content, pcName, softName;
  bool loading;
  Widget checkbox(String title, bool boolValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.06,
          ),
          width: MediaQuery.of(context).size.width * 0.40,
          child: Text(
            title,
            style: TextStyle(
              color: Color(0xffD64550),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Checkbox(
          value: boolValue,
          onChanged: (bool value) {
            /// manage the state of each value
            setState(() {
              switch (title) {
                case "Install New":
                  installNew = value;
                  break;
                case "Admin rights":
                  admin = value;
                  break;
                case "OS Issue":
                  os = value;
                  break;
                case "Boot up":
                  bootup = value;
                  break;
                case "Login":
                  login = value;
                  break;
              }
            });
          },
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Software Request".toUpperCase(),
            style: TextStyle(
              letterSpacing: 2,
              color: Color(0xffD64550),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height * 0.30,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.01),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        checkbox("Install New", installNew),
                        checkbox("Admin rights", admin),
                        checkbox("OS Issue", os),
                        checkbox("Boot up", bootup),
                        checkbox("Login", login),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          controller: _pcNameController,
                          validator: (value) {
                            if (value.isEmpty)
                              return "PC ID should not be empty.";
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              pcName = value;
                            });
                          },
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red, //this has no effect
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: "PC ID",
                            icon: Icon(
                              Icons.computer_outlined,
                              color: Color(0xffD64550),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: TextFormField(
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          controller: _softwareReqController,
                          validator: (value) {
                            if (value.isEmpty)
                              return "Request form should not be empty.";
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              content = value;
                            });
                          },
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red, //this has no effect
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            labelText: "Request form",
                            icon: Icon(
                              Icons.add_comment_rounded,
                              color: Color(0xffD64550),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: (installNew == true)
                            ? TextFormField(
                                controller: _softwareController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return "Software name should not be empty.";
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    softName = value;
                                  });
                                },
                                cursorColor: Colors.white,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.red, //this has no effect
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  labelText: "Software name",
                                  icon: Icon(
                                    Icons.apps,
                                    color: Color(0xffD64550),
                                  ),
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width * 0.80,
                  height: 50.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: RaisedButton(
                    color: Color(0xffD64550),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        addSoftwareRequest(
                            admin,
                            installNew,
                            os,
                            bootup,
                            login,
                            softName,
                            content,
                            widget.userName,
                            pcName,
                            context);
                        setState(() {
                          loading = true;
                        });
                        if (error.isNotEmpty)
                          setState(() {
                            loading = false;
                          });
                      }
                    },
                    child: Text(
                      "Submit".toUpperCase(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  child: Container(
                    child: Text(
                      error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  child: loading == true
                      ? Container(
                          child: SpinKitWave(
                            color: Color(0xffD64550),
                          ),
                        )
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

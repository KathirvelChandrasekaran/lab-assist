import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_assist/services/roleAuth.dart';

// ignore: must_be_immutable
class RemoteResponse extends StatefulWidget {
  String userName, request;
  DocumentSnapshot documentSnapshot;
  DateTime dateTime;
  RemoteResponse(
      {this.userName, this.request, this.dateTime, this.documentSnapshot});
  @override
  _RemoteResponseState createState() => _RemoteResponseState();
}

class _RemoteResponseState extends State<RemoteResponse> {
  final _formKey = GlobalKey<FormState>();
  final String assetName3 = 'images/remote.svg';
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String userName, password, role;
  String error = "";
  bool loading, res;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Remote Access Response".toUpperCase(),
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
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SvgPicture.asset(
                      assetName3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      placeholderBuilder: (context) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            controller: _userNameController,
                            validator: (value) {
                              if (value.isEmpty)
                                return "User ID should not be empty.";
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                userName = value;
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
                              labelText: "User ID",
                              icon: Icon(
                                Icons.computer_outlined,
                                color: Color(0xffD64550),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty)
                                return "Password should not be empty.";
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            obscureText: true,
                            cursorColor: Colors.white,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red, //this has no effect
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: "Password",
                              icon: Icon(
                                Icons.vpn_key,
                                color: Color(0xffD64550),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
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
                                grantRemoteAccess(
                                    widget.userName,
                                    widget.request,
                                    widget.dateTime,
                                    userName,
                                    password,
                                    context,
                                    widget.documentSnapshot);
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
                              "Send Credentials".toUpperCase(),
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
                )
              ],
            ),
          ),
        ));
  }
}

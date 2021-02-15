import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_assist/services/adminService.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final String assetName1 = 'images/forgotPassword.svg';
  TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String userName;
  bool loading = false;

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
            "Forgot Password".toUpperCase(),
            style: TextStyle(
              letterSpacing: 2,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: SvgPicture.asset(
                      assetName1,
                      width: MediaQuery.of(context).size.width * 0.8,
                      placeholderBuilder: (context) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            controller: _userNameController,
                            validator: (value) {
                              if (value.isEmpty)
                                return "User name should not be empty.";
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
                              labelText: "User Name",
                              icon: Icon(
                                Icons.email,
                                color: Color(0xffD64550),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
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
                                setState(() {
                                  loading = true;
                                });
                                reqNewPassword(userName.toUpperCase(), context);
                              }
                            },
                            child: Text(
                              "Request new password".toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
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
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

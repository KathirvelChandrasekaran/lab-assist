import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_assist/screens/forgotPassword.dart';

import 'package:lab_assist/services/roleAuth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String userName, password, role = "admin";
  String error = "";
  bool loading, res;
  int roleVal = 0;
  final String assetName1 = 'images/auth.svg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  void _genderStateHandle(int val) {
    setState(() {
      roleVal = val;

      switch (roleVal) {
        case 0:
          role = "admin";
          break;
        case 1:
          role = "student";
          break;
        default:
      }
    });
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
            "Login".toUpperCase(),
            style: TextStyle(
              letterSpacing: 2,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: SvgPicture.asset(
                        assetName1,
                        width: MediaQuery.of(context).size.width * 0.6,
                        placeholderBuilder: (context) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                        Container(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.10,
                            right: MediaQuery.of(context).size.width * 0.10,
                          ),
                          width: MediaQuery.of(context).size.width * 0.80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.supervised_user_circle,
                                color: Color(0xffD64550),
                              ),
                              Radio(
                                value: 0,
                                groupValue: roleVal,
                                onChanged: _genderStateHandle,
                                activeColor: Color(0xffD64550),
                              ),
                              Text(
                                "Admin",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              Radio(
                                value: 1,
                                groupValue: roleVal,
                                onChanged: _genderStateHandle,
                                activeColor: Color(0xffD64550),
                              ),
                              Text(
                                "Student",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
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
                                dynamic result = await authentication(
                                    userName.toUpperCase(),
                                    password,
                                    role,
                                    context);
                                setState(() {
                                  error = result;
                                  loading = true;
                                });
                                print(error);
                                if (error != '')
                                  setState(() {
                                    loading = false;
                                  });
                              }
                            },
                            child: Text(
                              "Login".toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Container(
                            child: Text(
                              'Forgot password',
                              style: TextStyle(
                                color: Color(0xffD64550),
                                fontSize: 15,
                              ),
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

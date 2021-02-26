import 'package:flutter/material.dart';
import 'package:lab_assist/screens/acceptedRemote.dart';
import 'package:lab_assist/screens/login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_assist/services/roleAuth.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  String userName;
  Profile({this.userName});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String assetName3 = 'images/profile.svg';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();

  String password, error = "", result;
  bool loading;

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
            "Profile".toUpperCase(),
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
                      width: MediaQuery.of(context).size.width * 0.6,
                      placeholderBuilder: (context) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Color(0xffD64550),
                    width: 1.0,
                  ))),
                  child: Text(
                    widget.userName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
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
                            labelText: "New Password",
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
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width * 0.80,
                        height: 50.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: RaisedButton(
                          color: Color(0xffD64550),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              dynamic result =
                                  updatePassword(widget.userName, password);
                              setState(() {
                                error = result;
                                loading = true;
                              });
                              if (error.isNotEmpty)
                                setState(() {
                                  loading = false;
                                });
                            }
                          },
                          child: Text(
                            "Update Password".toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.computer_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AcceptedRemote(userName: widget.userName),
              ),
            );
          },
        ),
      ),
    );
  }
}

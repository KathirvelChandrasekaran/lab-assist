import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lab_assist/screens/login.dart';
import 'package:lab_assist/screens/resetPassword.dart';
import 'package:lab_assist/services/adminService.dart';

class AddStudent extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String userName, password;
  String error = "";
  bool loading, res;
  final String assetName1 = 'images/addUser.svg';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Student".toUpperCase(),
          style: TextStyle(letterSpacing: 2, color: Color(0xffD64550)),
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
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.10,
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
                              dynamic result = await addStudent(
                                  userName.toUpperCase(), password, context);
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
                            "Add Student".toUpperCase(),
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.enhanced_encryption_rounded),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPassword(),
            ),
          );
        },
      ),
    );
  }
}

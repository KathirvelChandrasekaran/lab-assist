import 'package:flutter/material.dart';
import 'package:lab_assist/services/userRequests.dart';

// ignore: must_be_immutable
class RemoteAccessRequest extends StatefulWidget {
  String userName;
  RemoteAccessRequest({this.userName});
  @override
  _RemoteAccessRequestState createState() => _RemoteAccessRequestState();
}

class _RemoteAccessRequestState extends State<RemoteAccessRequest> {
  final _formKey = GlobalKey<FormState>();
  String reason;
  String error = "";
  bool loading;
  TextEditingController _remoteController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
            "Remote Access Request".toUpperCase(),
            style: TextStyle(
              letterSpacing: 2,
              color: Color(0xffD64550),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextFormField(
                            controller: _remoteController,
                            validator: (value) {
                              if (value.isEmpty)
                                return "Reason should not be empty.";
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                reason = value;
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
                              labelText: "Reason",
                              icon: Icon(
                                Icons.text_fields_rounded,
                                color: Color(0xffD64550),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * 0.40,
                          height: 40.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: RaisedButton(
                            color: Colors.white,
                            elevation: 5,
                            onPressed: () => _selectDate(context),
                            child: Text(
                              "Select date".toUpperCase(),
                              style: TextStyle(
                                  color: Color(0xffD64550),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Color(0xffD64550),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${selectedDate.toLocal()}".split(' ')[0],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
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
                                addRemoteAccess(reason, widget.userName,
                                    selectedDate, context);
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

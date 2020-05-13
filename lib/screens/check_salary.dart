import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckSalary extends StatelessWidget {
  String salary;

  void calculatesalary(
      BuildContext context, String name, int usersalary) async {
    final datas = await Firestore.instance
        .collection('Attendance')
        .where('Username', isEqualTo: name)
        .getDocuments();

    print(datas.documents.length);

    int monthday = DateTime.now().month;
    int day = DateTime.now().day;
    int year = DateTime.now().year;

    var beginningNextMonth = (monthday < 12)
        ? new DateTime(year, monthday + 1, 0)
        : new DateTime(year + 1, 1, day);

    print(beginningNextMonth);

    if (usersalary != null) {
      var totalMonthSalary =
          usersalary / beginningNextMonth.day * datas.documents.length;

      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  'Success',
                  style: TextStyle(color: Colors.black),
                ),
                content: Text(
                  'Your Salary of this month is $totalMonthSalary',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  FlatButton(
                    color: Colors.purple,
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(ctx).pop(true);
                    },
                  ),
                ],
              ));

      print(totalMonthSalary);
    }
  }

  //salary / no.of.days * presentdays

  static const routeArgs = '/checksalary';
  @override
  Widget build(BuildContext context) {
    var userdata = Provider.of<AuthProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Salary'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please provide a value.';
                  }
                  return null;
                },
                onChanged: (value) => salary = value,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: 'Enter Your Salary',
                    prefix: Icon(
                      Icons.attach_money,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                onPressed: () {
                  if (salary == null) {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text(
                                'Error',
                                style: TextStyle(color: Colors.black),
                              ),
                              content: Text(
                                'Please Enter Salary',
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                FlatButton(
                                  color: Colors.purple,
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop(true);
                                  },
                                ),
                              ],
                            ));
                  }
                  calculatesalary(
                      context, userdata.userName, int.parse(salary));
                },
                child: Text(
                  'Get Salary',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

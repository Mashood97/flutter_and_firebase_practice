import 'package:flutter/material.dart';
import 'package:flutterandfirebasepractice/providers/auth_provider.dart';
import 'package:flutterandfirebasepractice/screens/auth_screen.dart';
import 'package:flutterandfirebasepractice/screens/check_user_attendance_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeArgs = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(userdata.photoUrl),
                      radius: 40,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      userdata.userName,
                      style: Theme.of(context).textTheme.title,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MarkAttendanceWidget(
                          userId: userdata.userId,
                          userName: userdata.userName,
                        ),
                        RaisedButton(
                          onPressed: () {
                            userdata.logout();
                            Navigator.of(context)
                                .pushReplacementNamed(AuthScreen.routeArgs);
                          },
                          child: Text(
                            'Logout',
                            style: Theme.of(context).textTheme.title,
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                CheckUserAttendanceScreen.routeArgs);
                          },
                          child: Text(
                            'Check My Attendance',
                            style: Theme.of(context).textTheme.title,
                          ),
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarkAttendanceWidget extends StatelessWidget {
  final String userId;
  final String userName;

  MarkAttendanceWidget({this.userId, this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          DateFormat.yMMMEd().format(
            DateTime.now(),
          ),
          style: Theme.of(context).textTheme.title.copyWith(
                color: Colors.black,
              ),
        ),
        FlatButton(
          child: Text(
            'Mark Attendance',
            style: Theme.of(context).textTheme.title,
          ),
          onPressed: () {
            Provider.of<AuthProvider>(context, listen: false)
                .markAttendanceOfUser(userId, userName, DateTime.now(), true)
                .then((_) {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text('Success'),
                        content: Text('Attendance Marked Successfully'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: Theme.of(context).textTheme.title,
                            ),
                            color: Theme.of(context).accentColor,
                          )
                        ],
                      ));
            });
          },
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}

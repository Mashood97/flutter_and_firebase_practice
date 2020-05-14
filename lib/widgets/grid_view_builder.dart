import 'package:flutter/material.dart';
import 'package:flutterandfirebasepractice/screens/check_salary.dart';
import 'package:flutterandfirebasepractice/screens/check_user_attendance_screen.dart';
import 'package:flutterandfirebasepractice/screens/edit_profile_screen.dart';
import '../widgets/grid_view_item.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:geolocator/geolocator.dart';

class GridViewBuilder extends StatefulWidget {
  final String userid;
  final String userName;

  GridViewBuilder(this.userid, this.userName);

  @override
  _GridViewBuilderState createState() => _GridViewBuilderState();
}

class _GridViewBuilderState extends State<GridViewBuilder> {
  var data = [];
  int i = 0;
  void markAttendance() async {
    if (i == 0) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      print(position.longitude);
      print('${position.latitude} latlng');
      final double distance = await Geolocator().distanceBetween(
          position.latitude, position.longitude, 24.931225, 67.062711);
      print('$distance distaance total');
      if (distance < 20) {
        Provider.of<AuthProvider>(context)
            .markAttendanceOfUser(
                widget.userid, widget.userName, DateTime.now(), true)
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
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        color: Theme.of(context).accentColor,
                      )
                    ],
                  ));
        });
        i++;
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Failed'),
                  content: Text('Please Reach Daily Foods Headoffice'),
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
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      color: Theme.of(context).accentColor,
                    )
                  ],
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Done'),
                content: Text('You have already marked Attendance'),
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
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    color: Theme.of(context).accentColor,
                  )
                ],
              ));
    }
  }

  void checkAttendance() {
    Navigator.of(context).pushNamed(CheckUserAttendanceScreen.routeArgs);
  }

  void editProfile() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Success'),
              content: Text('Under Development'),
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
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  color: Theme.of(context).accentColor,
                )
              ],
            ));
  }

  void checkSalary() {
    Navigator.of(context).pushNamed(CheckSalary.routeArgs);
  }

  @override
  void initState() {
    super.initState();

    data = [
      {
        'title': 'Mark Attendance',
        'icon': Icons.check_circle,
        'color': Colors.green,
        'function': markAttendance,
      },
      {
        'title': 'Check Attendance',
        'icon': Icons.calendar_today,
        'color': Colors.amber,
        'function': checkAttendance,
      },
      {
        'title': 'Edit Profile',
        'icon': Icons.person_pin,
        'color': Colors.deepOrangeAccent,
        'function': editProfile,
      },
      {
        'title': 'Check Salary',
        'icon': Icons.attach_money,
        'color': Colors.purple,
        'function': checkSalary,
      }
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (ctx, i) => GridItem(
        title: data[i]['title'],
        icon: data[i]['icon'],
        iconColor: data[i]['color'],
        function: data[i]['function'],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterandfirebasepractice/providers/auth_provider.dart';
import 'package:flutterandfirebasepractice/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import '../widgets/grid_view_builder.dart';
import '../widgets/custom_clipper.dart';

class HomeScreen extends StatelessWidget {
  static const routeArgs = '/home-screen';

  Widget getDashboardData(BuildContext context, var userdata) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.5,
            child: GridViewBuilder(userdata.userId, userdata.userName),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.blueAccent,
                Colors.lightBlue,
              ], end: Alignment.bottomRight, begin: Alignment.bottomLeft)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: NetworkImage(userdata.photoUrl),
                        image: NetworkImage(userdata.photoUrl),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    userdata.userName,
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
            ),
          ),
          getDashboardData(context, userdata),
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        onPressed: () {
          userdata.logout();
          Navigator.of(context).pushReplacementNamed(AuthScreen.routeArgs);
        },
      ),
    );
  }
}

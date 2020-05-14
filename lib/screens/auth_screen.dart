import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:geolocator/geolocator.dart';

class AuthScreen extends StatelessWidget {
  static const routeArgs = '/auth-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              color: Theme.of(context).accentColor,
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Daily Foods Attendance System',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  fontSize: 22,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SignInButton(
                      Buttons.Google,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                      
                          Provider.of<AuthProvider>(context, listen: false)
                              .signInwithGoogle()
                              .then((_) {
                            Navigator.of(context)
                                .pushReplacementNamed(HomeScreen.routeArgs);
                          });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

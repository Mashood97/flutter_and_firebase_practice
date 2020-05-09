import 'package:flutter/material.dart';
import 'package:flutterandfirebasepractice/screens/check_user_attendance_screen.dart';
import './screens/auth_screen.dart';
import './screens/home_screen.dart';
import './providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(SetupScreen());

class SetupScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AuthProvider(),
          ),
        ],
        child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.
              primarySwatch: Colors.purple,
              accentColor: Colors.amber,
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                subtitle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            home: auth.isAuth
                ? HomeScreen()
                : FutureBuilder(
                    future: auth.getAutoLoginData(),
                    builder: (ctx, data) =>
                        data.connectionState == ConnectionState.waiting
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : AuthScreen(),
                  ),
            routes: {
              AuthScreen.routeArgs: (ctx) => AuthScreen(),
              HomeScreen.routeArgs: (ctx) => HomeScreen(),
              CheckUserAttendanceScreen.routeArgs: (ctx) =>
                  CheckUserAttendanceScreen(),
            },
          ),
        ));
  }
}

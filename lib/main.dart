import 'package:flutter/material.dart';
import 'package:flutterandfirebasepractice/screens/check_salary.dart';
import 'package:flutterandfirebasepractice/screens/check_user_attendance_screen.dart';
import 'package:flutterandfirebasepractice/screens/edit_profile_screen.dart';
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
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
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
              CheckSalary.routeArgs:(ctx)=>CheckSalary(),
              CheckUserAttendanceScreen.routeArgs: (ctx) =>
                  CheckUserAttendanceScreen(),
              EditProfile.routeArgs: (ctx) => EditProfile(),
            },
          ),
        ));
  }
}

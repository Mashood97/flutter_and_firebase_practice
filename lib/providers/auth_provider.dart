import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final Firestore _firestore = Firestore.instance;

class AuthUser {
  final String userid;
  final String username;
  final String email;
  final String photourl;

  AuthUser({this.userid, this.email, this.photourl, this.username});
}

class AttendanceUser {
  final bool attendance;
  final String id;
  final String name;
  final String dateTime;

  AttendanceUser({this.attendance, this.dateTime, this.name, this.id});
}

class AuthProvider with ChangeNotifier {
  List<AuthUser> _usersList = [];
  List<AttendanceUser> _AttendanceList = [];

  String _userId;
  String _userName;
  String _email;
  String _photoUrl;
  String _isActive = '1';
  var documentId;

  bool get isAuth {
    return _userId != null;
  }

  List<AuthUser> get getUserList => [..._usersList];

  List<AttendanceUser> get getAttendanceList => [..._AttendanceList];

  int get getUserListLength => _usersList.length;

  int get getAttendanceListLength => _AttendanceList.length;

  String get userId => _userId;

  String get userName => _userName;

  String get email => _email;

  String get photoUrl => _photoUrl;

  String get isActive => _isActive;

  Future<FirebaseUser> signInwithGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication auth =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );

      final AuthResult authResult =
          await firebaseAuth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      _usersList.add(
        AuthUser(
          userid: user.uid,
          email: user.email,
          photourl: user.photoUrl,
          username: user.displayName,
        ),
      );

      documentId = _firestore.collection('Users').add({
        'email': user.email,
        'userPhoto': user.photoUrl,
        'userName': user.displayName,
        'dateTime': DateFormat().add_yMMMEd().format(DateTime.now()),
        'isActive': _isActive,
      });

      _userId = user.uid;
      _email = user.email;
      _photoUrl = user.photoUrl;
      _userName = user.displayName;

      notifyListeners();

      final sharefPref = await SharedPreferences.getInstance();
      final userData = json.encode({
        'userid': _userId,
        'username': _userName,
        'email': _email,
        'userphoto': _photoUrl,
        'isActive': _isActive,
      });
      sharefPref.setString('AuthData', userData);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> getAutoLoginData() async {
    final pref = await SharedPreferences.getInstance();
    if (!pref.containsKey('AuthData')) {
      return false;
    }
    final extractedData =
        json.decode(pref.getString('AuthData')) as Map<String, Object>;
    _userId = extractedData['userid'];
    _userName = extractedData['username'];
    _email = extractedData['email'];
    _photoUrl = extractedData['userphoto'];
    _isActive = extractedData['isActive'];
    notifyListeners();
    return true;
  }

  void logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    notifyListeners();
    _userId = null;
    _userName = null;
    _photoUrl = null;
    _email = null;
    _isActive = '0';
//
//    await _firestore.collection('Users').document(documentId).updateData({
//      'isActive': isActive,
//    });

    notifyListeners();
    setAllDataToNull();
  }

  void setAllDataToNull() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  Future<void> markAttendanceOfUser(String userIds, String usernames,
      DateTime datatime, bool attendance) async {
    try {
      String formattedDate =
          DateFormat('yyyy-MM-dd – HH:mm:ss').format(datatime);
      await _firestore.collection('Attendance').add(({
            'userId': userIds,
            'Username': usernames,
            'datatime': formattedDate,
            'attendance': attendance,
          }));
      _AttendanceList.add(AttendanceUser(
        name: usernames,
        id: userIds,
        dateTime: formattedDate,
        attendance: attendance,
      ));

      final sharefPref = await SharedPreferences.getInstance();
      final attendanceData = json.encode({
        'userId': userIds,
        'Username': usernames,
        'datatime': formattedDate,
        'attendance': attendance,
      });
      sharefPref.setString('attendanceData', attendanceData);
    } catch (e) {
      throw e;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/task_list.dart';

class CheckUserAttendanceScreen extends StatelessWidget {
  static const routeArgs = '/check-screen';

  // void getdaata(BuildContext context) async {
  //   final data =
  //       await Firestore.instance.collection('Attendance').getDocuments();
  //   for (var d in data.documents) {
  //     print(d.data);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Attendance'),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('Attendance')
              .where('Username', isEqualTo: userData.userName)
              .orderBy('datatime')
              .snapshots(),
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return TaskList(
              snapshot.data.documents,
            );
          },
        ),
      ),
    );
  }
}

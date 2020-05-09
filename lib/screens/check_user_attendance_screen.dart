import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterandfirebasepractice/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CheckUserAttendanceScreen extends StatelessWidget {
  static const routeArgs = '/check-attendance';

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: StreamBuilder(
            stream: Firestore.instance
                .collection('Attendance')
                .document()
                .collection(providerData.userName)
                .where('Username', isEqualTo: providerData.userName)
                .snapshots(),
            builder: (context, snapshot) {
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
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<DocumentSnapshot> document;

  TaskList(this.document);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (ctx, i) => Divider(),
        itemCount: document.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            title: Text(document[i].data['Username']),
            subtitle: Text(document[i].data['datatime']),
          );
        });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Text(
                '#${i + 1}',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            title: Text(
              document[i].data['Username'].toString(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(document[i].data['datatime'].toString()),
            trailing: document[i].data['attendance']
                ? Text(
              'Present',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            )
                : null,
          );
        });
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class EditProfile extends StatelessWidget {
  static const routeArgs = '/edit_profile';

  Widget addPhotoRow(BuildContext context, var userdata) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(userdata.photoUrl),
          radius: 40,
        ),
        SizedBox(
          width: 10,
        ),
        FlatButton(
          child: Text(
            'Add Photo',
            style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 16),
          ),
          onPressed: () {},
          color: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(15),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userdata = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SafeArea(
        child: Form(
          key: UniqueKey(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              addPhotoRow(context, userdata),
            ],
          ),
        ),
      ),
    );
  }
}

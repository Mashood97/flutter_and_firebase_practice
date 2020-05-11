import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Function function;
  GridItem({this.title, this.iconColor, this.icon, this.function});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: InkWell(
        splashColor: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        onTap: function,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                icon,
                color: iconColor,
                size: 40,
              ),
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class Articles extends StatefulWidget {

  Articles({Key key}) : super(key: key);

  @override
  _Articles createState() => _Articles();
}


class _Articles extends State<Articles> {

  @override
  Widget build(BuildContext build) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('La partie Articles n\'est pas encore disponible.')
          ],
        )
    );
  }
}
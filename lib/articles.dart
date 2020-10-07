import 'package:flutter/material.dart';


class Articles extends StatefulWidget {

  Articles({Key key}) : super(key: key);

  @override
  _Articles createState() => _Articles();
}


class _Articles extends State<Articles> {

  @override
  Widget build(BuildContext build) {
    return Container(
        height: 300,
        child: Text('Do the articles part')
    );
  }
}
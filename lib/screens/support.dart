import 'package:flutter/material.dart';
import 'package:overcomers_place/constants.dart';

class SupportScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
    AppBar(title: Text('Support'),backgroundColor: kSecondColor,),
        ],
    );
  }
}


class SupportAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Support Us'),
    );
  }
}


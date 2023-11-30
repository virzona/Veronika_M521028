import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_environtment/features/home/widgets/appbar_widget.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [],
      ),
    );
  }
}
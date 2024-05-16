import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blank Page'),
      ),
      body: Center(
        child: Text('This is a blank page'),
      ),
    );
  }
}

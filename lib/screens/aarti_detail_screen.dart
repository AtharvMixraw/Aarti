import 'package:flutter/material.dart';

class AartiDetailScreen extends StatelessWidget {
  final String title;
  AartiDetailScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Lyrics of $title will be displayed here'),
      ),
    );
  }
}

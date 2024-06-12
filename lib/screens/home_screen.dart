import 'package:flutter/material.dart';
import 'package:aarti/widgets/aarti_card.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aarti App'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          AartiCard(title: 'Hanuman Aarti'),
          AartiCard(title: 'Ganesh Aarti'),
        ],
      ),
    );
  }
}

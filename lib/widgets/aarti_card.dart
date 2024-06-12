import 'package:flutter/material.dart';
import 'package:aarti/screens/aarti_detail_screen.dart';

class AartiCard extends StatelessWidget {
  final String title;
  AartiCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AartiDetailScreen(title: title)),
          );
        },
        child: Center(
          child: Text(title),
        ),
      )
    );
  }
}

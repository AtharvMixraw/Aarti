import 'package:aarti/models/aarti_model.dart';
import 'package:flutter/material.dart';
import 'package:aarti/screens/aarti_detail_screen.dart';

class AartiCard extends StatelessWidget {
  final Aarti aarti;
  AartiCard({required this.aarti});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[100],
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AartiDetailScreen(aarti: aarti)),
          );
        },
        child: Center(
          child: Text(
            aarti.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    );
  }
}

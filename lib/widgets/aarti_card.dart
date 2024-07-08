import 'package:flutter/material.dart';
import 'package:aarti/screens/aarti_detail_screen.dart';
import 'package:aarti/models/aarti_model.dart';

class AartiCard extends StatelessWidget {
  final Aarti aarti;
  final Color myPink = Color(0xFFE7C0C9);
  AartiCard({required this.aarti});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: myPink,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AartiDetailScreen(aarti: aarti)),
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              aarti.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'SourceCodePro',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

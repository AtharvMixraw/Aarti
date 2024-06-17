import 'package:flutter/material.dart';
import 'package:aarti/models/aarti_model.dart';

class AartiDetailScreen extends StatelessWidget {
  final Aarti aarti;
  AartiDetailScreen({required this.aarti});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(aarti.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: aarti.lyrics.length,
          itemBuilder: (context, index) {
            String line = aarti.lyrics[index];
            return ListTile(
              title: Text(line),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Meaning'),
                      content: Text(aarti.meanings[line] ?? 'No meaning available'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

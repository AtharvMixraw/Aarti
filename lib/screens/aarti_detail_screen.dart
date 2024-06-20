import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aarti/models/aarti_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:aarti/screens/display_image_screen.dart';

class AartiDetailScreen extends StatefulWidget {
  final Aarti aarti;

  AartiDetailScreen({required this.aarti});

  @override
  _AartiDetailScreenState createState() => _AartiDetailScreenState();
}

class _AartiDetailScreenState extends State<AartiDetailScreen> {
  List<String> selectedLines = [];
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(widget.aarti.title),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: selectedLines.isEmpty
                ? null
                : () {
              _shareSelectedLines();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.aarti.lyrics.length,
          itemBuilder: (context, index) {
            String line = widget.aarti.lyrics[index];
            return ListTile(
              title: Text(line),
              onTap: () {
                setState(() {
                  if (selectedLines.contains(line)) {
                    selectedLines.remove(line);
                  } else {
                    selectedLines.add(line);
                  }
                });
              },
              onLongPress: () {
                _showMeaning(line);
              },
              selected: selectedLines.contains(line),
              selectedTileColor: Colors.orange[100],
            );
          },
        ),
      ),
    );
  }

  void _showMeaning(String line) {
    String meaning = widget.aarti.meanings[line] ?? 'No meaning available';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow,
          title: Text('Meaning',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(meaning),
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
  }

  void _shareSelectedLines() async {
    String text = selectedLines.join('\n');
    Uint8List? image = await _generateImage(text);
    if (image != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayImageScreen(image: image),
        ),
      );
    }
  }

  Future<Uint8List?> _generateImage(String text) async {
    Widget textWidget = Container(
      color: Colors.orangeAccent,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Aarti App',
            style: TextStyle(
              fontFamily: 'SourceCodePro',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'SourceCodePro',
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    Uint8List? image = await screenshotController.captureFromWidget(
      textWidget,
      delay: Duration(milliseconds: 10),
    );

    return image;
  }
}

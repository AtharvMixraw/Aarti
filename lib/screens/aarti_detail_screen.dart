import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aarti/models/aarti_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:aarti/screens/display_image_screen.dart';

class AartiDetailScreen extends StatefulWidget {
  final Aarti aarti;
  AartiDetailScreen({super.key, required this.aarti});

  @override
  _AartiDetailScreenState createState() => _AartiDetailScreenState();
}

class _AartiDetailScreenState extends State<AartiDetailScreen> {
  List<String> selectedLines = [];
  final ScreenshotController screenshotController = ScreenshotController();
  final Color myYellow = Color(0xEFF1E6C6);
  final Color myPink = Color(0xFFF7E8FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myYellow,
        title: Text(widget.aarti.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: selectedLines.isEmpty
                ? null
                : () {
              _shareSelectedLines();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            widget.aarti.backgroundImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.aarti.lyrics.length,
                itemBuilder: (context, index) {
                  String line = widget.aarti.lyrics[index];
                  return ListTile(
                    title: Text(
                      line,
                      style: TextStyle(color: Colors.white), // Ensure text is visible
                    ),
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
          ),
        ],
      ),
    );
  }

  void _showMeaning(String line) {
    String meaning = widget.aarti.meanings[line] ?? 'No meaning available';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: myPink,
          title: const Text(
            'Meaning',
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
    final Color imageColor = Color(0xFFE5E0CC);

    Widget textWidget = Container(
      color: imageColor,
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'My Favourite Shloka',
            style: TextStyle(
              fontFamily: 'SourceCodePro',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'SourceCodePro',
              fontSize: 18,
              color: Colors.black54,
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

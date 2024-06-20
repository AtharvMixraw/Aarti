import 'dart:typed_data';
import 'package:flutter/material.dart';

class DisplayImageScreen extends StatelessWidget {
  final Uint8List image;

  DisplayImageScreen({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Image'),
      ),
      body: Center(
        child: Image.memory(image),
      ),
    );
  }
}

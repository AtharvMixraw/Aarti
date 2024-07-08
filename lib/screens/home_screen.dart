import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aarti/widgets/aarti_card.dart';
import 'package:aarti/models/aarti_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<Aarti>> _loadAartiTitles() async {
    final String response = await rootBundle.loadString('assets/assets/aartis/aartis.json');
    final data = await json.decode(response) as Map<String, dynamic>;
    return data.entries.map((entry) => Aarti.fromJson(entry.key, entry.value)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Aarti',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SourceCodePro',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white38,
        child: FutureBuilder<List<Aarti>>(
          future: _loadAartiTitles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  children: snapshot.data!.map((aarti) => AartiCard(aarti: aarti)).toList(),
                ),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

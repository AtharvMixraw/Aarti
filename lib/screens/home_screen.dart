import 'package:flutter/material.dart';
import 'package:aarti/widgets/aarti_card.dart';

class HomeScreen extends StatelessWidget {

  Future<List<String>> _loadAartiTitles() async {
    await Future.delayed(Duration(seconds: 3));
    return ['Hanuman Aarti' , 'Ganesh Aarti', 'Shiva Aarti', 'Durga Aarti'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[200],
        title: Center( // Wrap the Text widget with Center
          child: Text(
            'Aarti',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ),
      body: Container(
        color: Colors.orangeAccent,  // Set the desired background color here
        child: FutureBuilder<List<String>>(
          future: _loadAartiTitles(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  children: snapshot.data!.map((title) => AartiCard(title: title)).toList(),
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}

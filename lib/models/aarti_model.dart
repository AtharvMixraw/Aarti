class Aarti {
  final String title;
  final List<String> lyrics;
  final Map<String, String> meanings;

  Aarti({required this.title, required this.lyrics, required this.meanings});

  factory Aarti.fromJson(String title, Map<String, dynamic>json){
    return Aarti(title: title, lyrics: List<String>.from(json['lyrics']), meanings: Map<String,String>.from(json['meanings']));
  }
}

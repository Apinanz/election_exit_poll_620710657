class ElectionResult {
  final int number;
  final String title;
  final String fullName;
  final int score;

  ElectionResult({
    required this.number,
    required this.title,
    required this.fullName,
    required this.score,

  });

  factory ElectionResult.fromJson(Map<String, dynamic> json){
    return ElectionResult(
        number: json['number'],
        title: json['title'],
        fullName: json['fullName'],
        score: json['score']
    );
  }


  @override
  String toString() {
    return '$title $fullName';
  }

}
class ElectionItem {
  final int number;
  final String title;
  final String fullName;

  ElectionItem({
    required this.number,
    required this.title,
    required this.fullName,
  });

  factory ElectionItem.fromJson(Map<String, dynamic> json) {
    return ElectionItem(
      number: json['number'],
      title: json['title'],
      fullName: json['fullName'],
    );
  }

  @override
  String toString() {
    return '$title $fullName';
  }
}

class Todo {
  final int? id;
  final String title;
  final String content;
  final String date;

  Todo({
    this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }
}

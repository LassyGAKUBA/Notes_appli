class Note {
  String id;
  String title;
  String content;

  Note({required this.id, required this.title, required this.content});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
    };
  }
}
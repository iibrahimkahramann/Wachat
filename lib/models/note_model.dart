class Note {
  final String title;
  final String text;

  Note({
    required this.title,
    required this.text,
  });

  Map<String, String> toJson() {
    return {
      'title': title,
      'text': text,
    };
  }

  static Note fromJson(Map<String, String> json) {
    return Note(
      title: json['title']!,
      text: json['text']!,
    );
  }
}

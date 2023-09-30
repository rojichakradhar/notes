// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteSchema {
  String title;
  String content;
  String date;
  String index;

  NoteSchema({
    required this.title,
    required this.content,
    required this.date,
    required this.index,
  });

  NoteSchema copyWith({
    String? title,
    String? content,
    String? date,
  }) {
    return NoteSchema(
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      index: index,
    );
  }

  @override
  bool operator ==(covariant NoteSchema other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.content == content &&
        other.date == date &&
        other.index == index;
  }

  @override
  int get hashCode {
    return title.hashCode ^ content.hashCode ^ date.hashCode ^ index.hashCode;
  }
}

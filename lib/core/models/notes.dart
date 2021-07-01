class Notes {
  String id;
  String title;
  String content;
  int timeStamp;
  int editTimeStamp;
  bool isStarred;
  Notes(
      {required this.content,
      required this.id,
      required this.editTimeStamp,
      required this.isStarred,
      required this.timeStamp,
      required this.title});
  factory Notes.fromJson(Map<dynamic, dynamic> note, String id) {
    assert(note != null, 'Note cannot be null!');
    return Notes(
        title: note['title'],
        id: id,
        content: note['content'],
        editTimeStamp: note['editTimeStamp'],
        isStarred: note['isStarred'] ?? false,
        timeStamp: note['timeStamp']);
  }
  static Map<String, dynamic> toJson(Notes note) {
    return {
      'title': note.title,
      'id': note.id,
      'content': note.content,
      'editTimeStamp': note.editTimeStamp,
      'isStarred': note.isStarred,
      'timeStamp': note.timeStamp
    };
  }
}

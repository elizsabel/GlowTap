class EducationModel {
  final String? uid;
  final String title;
  final String category;
  final String content;

  EducationModel({
    this.uid,
    required this.title,
    required this.category,
    required this.content,
  });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "title": title,
      "category": category,
      "content": content,
    };
  }

  factory EducationModel.fromMap(Map<String, dynamic> map) {
    return EducationModel(
      uid: map["uid"],
      title: map["title"] ?? "",
      category: map["category"] ?? "",
      content: map["content"] ?? "",
    );
  }
}

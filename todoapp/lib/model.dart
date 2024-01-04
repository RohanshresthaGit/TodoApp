class Model {
  String? title;
  String? description;
  bool? status;
  Model({this.title, this.description, this.status});

  Map<String, dynamic> toMap() {
    return {"title": title, "description": description, "status": status};
  }

  userModel(Map<String, dynamic> map) {
    return Model(
        title: map['title'],
        description: map['description'],
        status: map["status"]);
  }
}

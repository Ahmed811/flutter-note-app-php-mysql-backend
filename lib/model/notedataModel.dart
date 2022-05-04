class NoteDataModel {
  String? id;
  String? title;
  String? content;
  String? image;
  String? notesUsers;

  NoteDataModel(
      {this.id, this.title, this.content, this.image, this.notesUsers});

  NoteDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    image = json['image'];
    notesUsers = json['notes_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['notes_users'] = this.notesUsers;
    return data;
  }
}

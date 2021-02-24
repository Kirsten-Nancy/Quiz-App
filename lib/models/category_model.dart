class Category {
  int id;
  String categoryName;

  Category({this.id, this.categoryName});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], categoryName: json['name']);
  }
}

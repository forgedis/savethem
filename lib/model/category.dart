class Category {
  final String name;
  final String userId;

  Category({required this.name, required this.userId});

  Map<String, dynamic> toJson() => {
        'name': name,
        'userID': userId,
      };

  Category.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        userId = json['userID'];
}

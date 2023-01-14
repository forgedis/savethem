class Category {

  final String name;
  final String userID;

  Category({required this.name, required this.userID});

  Map<String, dynamic> toJson() => {
    'name': name,
    'userID': userID,
  };

  Category.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        userID = json['userID'];

}
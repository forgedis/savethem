class Spending {
  final String name;
  final DateTime date;
  final double price;
  final String category;
  final String userID;
  final String? imageID;


  Spending({required this.name, required this.date, required this.price, required this.category, required this.userID, this.imageID});

  Map<String, dynamic> toJson() => {
    'name': name,
    'date': date == null ? null : date.toIso8601String(),
    'price': price.toDouble(),
    'category': category,
    'userID': userID,
    'imageID': imageID,
  };

  Spending.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = DateTime.parse(json['date'].toString()),
        price = json['price'].toDouble(),
        category = json['category'],
        userID = json['userID'],
        imageID = json['imageID'];
}
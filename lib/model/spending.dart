class Spending {
  final String name;
  final DateTime date;
  final double price;
  final String? note;
  final String userID;
  final String categoryID;
  final String? imageID;


  Spending({required this.name, required this.date, required this.price, required this.userID, required this.categoryID, this.imageID, this.note});

  Map<String, dynamic> toJson() => {
    'name': name,
    'date': date == null ? null : date.toIso8601String(),
    'price': price.toDouble(),
    'note': note,
    'userID': userID,
    'categoryID': categoryID,
    'imageID': imageID,
  };

  Spending.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = DateTime.parse(json['date'].toString()),
        price = json['price'].toDouble(),
        note = json['note'],
        userID = json['userID'],
        categoryID = json['categoryID'],
        imageID = json['imageID'];
}
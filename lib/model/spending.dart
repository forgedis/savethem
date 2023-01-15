class Spending {
  final String name;
  final DateTime date;
  final double price;
  final String? note;
  final String userId;
  final String categoryId;
  final String? imageId;

  Spending(
      {required this.name,
      required this.date,
      required this.price,
      required this.userId,
      required this.categoryId,
      this.imageId,
      this.note});

  Map<String, dynamic> toJson() => {
        'name': name,
        'date': date == null ? null : date.toIso8601String(),
        'price': price.toDouble(),
        'note': note,
        'userID': userId,
        'categoryID': categoryId,
        'imageID': imageId,
      };

  Spending.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = DateTime.parse(json['date'].toString()),
        price = json['price'].toDouble(),
        note = json['note'],
        userId = json['userID'],
        categoryId = json['categoryID'],
        imageId = json['imageID'];
}

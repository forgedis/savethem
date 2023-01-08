class Receipt {
  final String userID;
  final String receiptName;
  final String date;
  final double price;


  Receipt({required this.userID, required this.receiptName, required this.date, required this.price});

  Map<String, dynamic> toJson() => {
    'userID': userID,
    'receiptName': receiptName,
    'date': date,
    'price': price.toDouble(),
  };

  Receipt.fromJson(Map<String, dynamic> json)
      : userID = json['userID'],
        receiptName = json['receiptName'],
        date = json['date'],
        price = json['price'].toDouble();
}
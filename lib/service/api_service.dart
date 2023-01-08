import 'package:appwrite/appwrite.dart';
import 'package:savethem/auth/resources/app_constants.dart';

import '../model/receipt.dart';

class ApiService {
  static ApiService? _instance;
  late final Client _client;
  late final Databases _database;

  ApiService._internal() {
    _client = Client(
      endPoint: AppConstants.endPoint).setProject(AppConstants.projectID).setSelfSigned();

    _database = Databases(_client);
  }

  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance!;
  }

  Future<Receipt> addReceipt({required Receipt receipt})
  async {
    final res = await _database.createDocument(databaseId: '63bad69541af7c758859', collectionId: '63bad6a430f009791d53', documentId: ID.unique(), data: receipt.toJson());
    return Receipt.fromJson(res.data);
  }

}
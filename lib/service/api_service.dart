import 'package:appwrite/appwrite.dart';
import 'package:savethem/auth/resources/app_constants.dart';

import '../model/spending.dart';

class ApiService {
  static ApiService? _instance;
  late final Client _client;
  late final Databases _database;
  late final Storage _storage;

  ApiService._internal() {
    _client = Client(
      endPoint: AppConstants.endPoint).setProject(AppConstants.projectID).setSelfSigned();

    _storage = Storage(_client);
    _database = Databases(_client);
  }

  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance!;
  }

  Future<Spending> addSpending({required Spending spending})
  async {
    final res = await _database.createDocument(databaseId: '63bad69541af7c758859', collectionId: '63bad6a430f009791d53', documentId: ID.unique(), data: spending.toJson());
    return Spending.fromJson(res.data);
  }

  Future<List<Spending>> getSpending({required String userID}) async {
    List<Spending> spendingList = [];
    final res = await _database.listDocuments(databaseId: '63bad69541af7c758859', collectionId: '63bad6a430f009791d53', queries: [Query.equal('userID', userID), Query.notEqual('category', 'custom')]);

    for (var element in res.documents) {
      spendingList.add(Spending.fromJson(element.data));
    }

    return spendingList;
  }
  
  Future<String> uploadImage(InputFile image) async {
    final res = await _storage.createFile(bucketId: '63bd51f45c86e93c4606', fileId: ID.unique(), file: image);
    String id = res.$id;
    return id ;
  }

}
import 'package:appwrite/appwrite.dart';
import 'package:savethem/auth/resources/app_constants.dart';
import '../model/spending.dart';
import '../model/user.dart';

class ApiService {
  static ApiService? _instance;
  late final Client _client;
  late final Databases _database;
  late final Storage _storage;
  late final Account _account;

  ApiService._internal() {
    _client = Client(
      endPoint: AppConstants.endPoint).setProject(AppConstants.projectID).setSelfSigned();

    _storage = Storage(_client);
    _database = Databases(_client);
    _account = Account(_client);
  }

  static ApiService get instance {
    if (_instance == null) {
      _instance = ApiService._internal();
    }
    return _instance!;
  }

  Future<User> getUser() async {
    final currentUser = await _account.get();
    return User(id: currentUser.$id, name: currentUser.name, email: currentUser.email, phone: currentUser.phone);
  }

  Future<Spending> addReceipt({required Spending receipt})
  async {
    final res = await _database.createDocument(databaseId: '63bad69541af7c758859', collectionId: '63bad6a430f009791d53', documentId: ID.unique(), data: receipt.toJson());
    return Spending.fromJson(res.data);
  }
  
  Future<String> uploadImage(InputFile image) async {
    final res = await _storage.createFile(bucketId: '63bd51f45c86e93c4606', fileId: ID.unique(), file: image);
    String id = res.$id;
    return id ;
  }

}
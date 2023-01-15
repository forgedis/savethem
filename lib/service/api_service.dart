import 'package:appwrite/appwrite.dart';
import '../auth/resources/app_constants.dart';
import '../model/spending.dart';
import '../model/category.dart';
import '../model/user.dart';

class ApiService {
  static ApiService? _instance;
  late final Client _client;
  late final Databases _database;
  late final Storage _storage;
  late final Account _account;

  ApiService._internal() {
    _client = Client(endPoint: AppConstants.endPoint)
        .setProject(AppConstants.projectID)
        .setSelfSigned();

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
    return User(
        id: currentUser.$id,
        name: currentUser.name,
        email: currentUser.email,
        phone: currentUser.phone);
  }

  Future<Spending> addSpending({required Spending spending}) async {
    final res = await _database.createDocument(
        databaseId: '63bad69541af7c758859',
        collectionId: '63bad6a430f009791d53',
        documentId: ID.unique(),
        data: spending.toJson());
    return Spending.fromJson(res.data);
  }

  Future<List<Spending>> getSpending({required String userId}) async {
    List<Spending> spendingList = [];
    final res = await _database.listDocuments(
        databaseId: '63bad69541af7c758859',
        collectionId: '63bad6a430f009791d53',
        queries: [Query.equal('userID', userId)]);

    for (var element in res.documents) {
      spendingList.add(Spending.fromJson(element.data));
    }

    return spendingList;
  }

  Future<Category> addCategory({required Category category}) async {
    final res = await _database.createDocument(
        databaseId: '63bad69541af7c758859',
        collectionId: '63c026a2bc6acf48e1e3',
        documentId: ID.unique(),
        data: category.toJson());
    return Category.fromJson(res.data);
  }

  Future<List<Category>> getCategory({required String userId}) async {
    List<Category> categoryList = [];
    final res = await _database.listDocuments(
        databaseId: '63bad69541af7c758859',
        collectionId: '63c026a2bc6acf48e1e3',
        queries: [Query.equal('userID', userId)]);

    for (var element in res.documents) {
      categoryList.add(Category.fromJson(element.data));
    }

    return categoryList;
  }

  Future<Category> getCategoryByID({required String categoryId}) async {
    final res = await _database.getDocument(
        databaseId: '63bad69541af7c758859',
        collectionId: '63c026a2bc6acf48e1e3',
        documentId: categoryId);

    return Category.fromJson(res.data);
  }

  Future<String> getCategoryID({required String categoryName}) async {
    String categoryId = '';
    final res = await _database.listDocuments(
        databaseId: '63bad69541af7c758859',
        collectionId: '63c026a2bc6acf48e1e3',
        queries: [Query.equal('name', categoryName)]);

    for (var element in res.documents) {
      categoryId = element.$id;
    }
    return categoryId;
  }

  Future<Category> updateCategory(
      {required String categoryId, required Category categoryToUpdate}) async {
    final res = await _database.updateDocument(
        databaseId: '63bad69541af7c758859',
        collectionId: '63c026a2bc6acf48e1e3',
        documentId: categoryId,
        data: categoryToUpdate.toJson());

    return Category.fromJson(res.data);
  }

  void deleteCategory({required String categoryId}) async {
    await _database.deleteDocument(
        databaseId: '63bad69541af7c758859',
        collectionId: '63c026a2bc6acf48e1e3',
        documentId: categoryId);
  }

  Future<String> uploadImage(InputFile image) async {
    final res = await _storage.createFile(
        bucketId: '63bd51f45c86e93c4606', fileId: ID.unique(), file: image);
    String id = res.$id;
    return id;
  }
}

import 'package:appwrite/appwrite.dart';
import '../resources/app_constants.dart';
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
        .setProject(AppConstants.projectId)
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

  Future loginUser({required String email, required String password}) async {
    final res = await _account.createEmailSession(email: email, password: password);
    return res;
  }

  Future signUpUser({required String name, required String email, required String password}) async {
    final res = await _account.create(userId: ID.unique(), email: email, password: password, name: name);
    return res;
  }

  Future signOutUser() async {
    final res = await _account.deleteSession(sessionId: 'current');
    return res;
  }

  Future<User> getUser() async {
    final currentUser = await _account.get();
    return User(
        id: currentUser.$id,
        name: currentUser.name,
        email: currentUser.email,
        phone: currentUser.phone);
  }

  Future<String> getUserId() async {
    final currentUser = await _account.get();
    String userId = currentUser.$id;
    return userId;
  }

  Future<Spending> addSpending({required Spending spending}) async {
    final res = await _database.createDocument(
        databaseId: AppConstants.databaseId,
        collectionId: AppConstants.spendingCollectionId,
        documentId: ID.unique(),
        data: spending.toJson());
    return Spending.fromJson(res.data);
  }

  Future<List<Spending>> getSpending({required String userId}) async {
    List<Spending> spendingList = [];
    final res = await _database.listDocuments(
        databaseId: AppConstants.databaseId,
        collectionId: AppConstants.spendingCollectionId,
        queries: [Query.equal('userID', userId)]);

    for (var element in res.documents) {
      spendingList.add(Spending.fromJson(element.data));
    }

    return spendingList;
  }

  Future<Category> addCategory({required Category category}) async {
    final res = await _database.createDocument(
        databaseId: AppConstants.databaseId,
        collectionId: AppConstants.categoryCollectionId,
        documentId: ID.unique(),
        data: category.toJson());
    return Category.fromJson(res.data);
  }

  Future<List<Category>> getCategory({required String userId}) async {
    List<Category> categoryList = [];
    final res = await _database.listDocuments(
        databaseId: AppConstants.databaseId,
        collectionId: AppConstants.categoryCollectionId,
        queries: [Query.equal('userID', userId)]);

    for (var element in res.documents) {
      categoryList.add(Category.fromJson(element.data));
    }

    return categoryList;
  }

  Future<Category> getCategoryById({required String categoryId}) async {
    final res = await _database.getDocument(
        databaseId: AppConstants.databaseId,
        collectionId: AppConstants.categoryCollectionId,
        documentId: categoryId);

    return Category.fromJson(res.data);
  }

  Future<String> getCategoryId({required String categoryName}) async {
    String categoryId = '';
    final res = await _database.listDocuments(
        databaseId: AppConstants.databaseId,
        collectionId: AppConstants.categoryCollectionId,
        queries: [Query.equal('name', categoryName)]);

    for (var element in res.documents) {
      categoryId = element.$id;
    }
    return categoryId;
  }

  Future<Category> updateCategory(
      {required String categoryId, required Category categoryToUpdate}) async {
    final res = await _database.updateDocument(
        databaseId: AppConstants.databaseId,
        collectionId: AppConstants.categoryCollectionId,
        documentId: categoryId,
        data: categoryToUpdate.toJson());

    return Category.fromJson(res.data);
  }

  void deleteCategory({required String categoryId}) async {
    await _database.deleteDocument(
        databaseId: AppConstants.databaseId,
        collectionId: AppConstants.categoryCollectionId,
        documentId: categoryId);
  }

  Future<String> uploadImage(InputFile image) async {
    final res = await _storage.createFile(
        bucketId: AppConstants.imageBucketId, fileId: ID.unique(), file: image);
    String id = res.$id;
    return id;
  }
}

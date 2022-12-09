import 'package:flutter/cupertino.dart';
import 'package:appwrite/appwrite.dart';
import 'package:savethem/core/resources/app_constants.dart';


class AuthState extends ChangeNotifier {

  Client client = Client();
  late Account account;

  AuthState() {
    _init();
  }
  
  _init() {
    client.setEndpoint(AppConstants.endPoint).setProject(AppConstants.projectID);
    account = Account(client);
    _checkIsLoggedIn();
  }

  _checkIsLoggedIn() async {
    try {
      var result = await account.get();
      print(result);
    }catch(e) {
      print(e);
    }
  }

  login(String email, String password) async {
    try{
      var result = await account.createEmailSession(email: email, password: password);
      print(result);
    }catch(e) {
      print(e);
    }
  }

  createAccount(String name, String email, String password) async {
    try{
      var result = await account.create(name: name, email: email, password: password, userId: ID.unique());
      print(result);
    }catch(e) {
      print(e);
    }
  }




}
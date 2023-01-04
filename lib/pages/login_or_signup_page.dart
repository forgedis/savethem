import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savethem/app_tree.dart';
import 'package:savethem/pages/login_page.dart';
import 'package:savethem/pages/signup_page.dart';
import '../auth/validation.dart';
import '../main.dart';

class LoginOrSignupPage extends ConsumerStatefulWidget {
  const LoginOrSignupPage({Key? key}) : super(key: key);
  static const String routeName = '/loginorsignuppage';

  @override
  ConsumerState<LoginOrSignupPage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginOrSignupPage> {

  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  Future<void> checkCurrentUser() async {
    try {
      final user = await ref.read(appwriteAccountProvider).get();
      Navigator.of(context).pushReplacementNamed(
        AppTree.routeName,
      );
    } on AppwriteException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Text(
                        'SaveThem',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35
                      ),
                    ),
                  ),
                  SizedBox(height: 350),
                  ElevatedButton(
                    child: Text(
                        "Sign me up!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(SignupPage.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Color(0xFF8a5bf5),
                      minimumSize: Size.fromHeight(60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  OutlinedButton(
                    child: Text(
                      "Already have an account?",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(60),
                      side: BorderSide(width: 3.0, color: Color(0xFF8a5bf5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

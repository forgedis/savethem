import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_tree.dart';
import 'login_page.dart';
import 'signup_page.dart';
import '../main.dart';

class LoginOrSignupPage extends ConsumerStatefulWidget {
  const LoginOrSignupPage({Key? key}) : super(key: key);
  static const String routeName = '/loginorsignuppage';

  @override
  ConsumerState<LoginOrSignupPage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginOrSignupPage> {
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
  void initState() {
    super.initState();
    checkCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF261c51),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Center(
                child: Text(
                  'SaveThem',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                ),
              ),
              const SizedBox(height: 350),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignupPage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF8a5bf5),
                  minimumSize: const Size.fromHeight(60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text(
                  "Sign me up!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginPage.routeName);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(60),
                  side: const BorderSide(width: 3.0, color: Color(0xFF8a5bf5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

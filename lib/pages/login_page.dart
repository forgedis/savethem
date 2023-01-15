import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app_tree.dart';
import '../auth/validation.dart';
import '../main.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  ConsumerState<LoginPage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  bool _obscuredText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF261c51),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Center(
                  child: Text(
                    'SaveThem',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 300),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  validator: emailValidation,
                  onSaved: (value) => _email = value,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Color(0xFF8a5bf5), width: 2),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                            color: Color(0xFF8a5bf5), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFF8a5bf5), width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide:
                              BorderSide(color: Colors.red.shade900, width: 2)),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.white,
                      )),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  validator: passwordValidation,
                  onSaved: (value) => _password = value,
                  obscureText: _obscuredText,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(color: Colors.red.shade900, width: 2)),
                    prefixIcon: const Icon(
                      Icons.vpn_key,
                      color: Colors.white,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscuredText = !_obscuredText;
                        });
                      },
                      child: Icon(
                          _obscuredText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          //TODO: 'Route to reset password page'
                          print('Forget password click');
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 30),
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: 5,
                            ),
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Color(0xFFf1cb46),
                              width: 1.0,
                            ))),
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: Color(0xFFf1cb46),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          ),
                        )),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFf1cb46),
                      child: IconButton(
                        onPressed: validateAndLogin,
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.black, size: 30),
                        color: const Color(0xFFf1cb46),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void validateAndLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await ref
            .read(appwriteAccountProvider)
            .createEmailSession(email: _email!, password: _password!);
        Navigator.of(context).pushReplacementNamed(AppTree.routeName);
      } on AppwriteException catch (e) {
        debugPrint(e.message);
      }
    }
  }
}

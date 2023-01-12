import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:savethem/service/api_service.dart';
import '../main.dart';
import '../model/user.dart';
import 'login_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  initState() {
    super.initState();
    getUser();
  }

  final nameTEC = TextEditingController();
  final emailTEC = TextEditingController();
  final phoneTEC = TextEditingController();

  User user = User(id: '1', name: 'test', email: 'test@test.dk', phone: '+45testest');
  bool isLoading = false;

  void getUser() async {
    setState(() => isLoading = true);
    final retrievedUser = await ApiService.instance.getUser();

    setState(() {
       user = retrievedUser;
    });

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    nameTEC.text = user.name;
    emailTEC.text = user.email;
    phoneTEC.text = user.phone;

    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) ...[
                SpinKitThreeBounce(
                  color: Colors.white,
                  size: 50.0,
                )
              ],
              if (!isLoading) ...[
                Center(
                  child: Text(user.name + "'s profile",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 50,
                    ),
                    maxRadius: 60,
                    backgroundColor: Color(0xFF8a5bf5),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  textAlign: TextAlign.center,
                  enabled: false,
                  controller: nameTEC,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Email',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  textAlign: TextAlign.center,
                  enabled: false,
                  controller: emailTEC,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'Phone',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  textAlign: TextAlign.center,
                  enabled: false,
                  controller: phoneTEC,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF8a5bf5), width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Center(
                  child: Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Log out",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.logout)
                        ],
                      ),
                      onPressed: () async {
                        try {
                          await ref
                              .read(appwriteAccountProvider)
                              .deleteSession(sessionId: 'current');
                          Navigator.of(context).pushReplacementNamed(
                            LoginPage.routeName,
                          );
                        } on AppwriteException catch (e) {
                          debugPrint(e.message);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF8a5bf5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

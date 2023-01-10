import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savethem/pages/login_page.dart';
import '../main.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {

  var user = null;

  @override
  initState() {
    getUser();
  }

  Future getUser() async{
    user = await ref.read(appwriteAccountProvider).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF261c51),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('test',
                style: TextStyle(fontSize: 40, color: Colors.white)),
            CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.black,
                size: 50,
              ),
              maxRadius: 60,
              backgroundColor: Color(0xFFf1cb46),
            ),
            ElevatedButton(
              onPressed: () async {
                // try {
                //   await ref
                //       .read(appwriteAccountProvider)
                //       .deleteSession(sessionId: 'current');
                //   Navigator.of(context).pushReplacementNamed(
                //     LoginPage.routeName,
                //   );
                // } on AppwriteException catch (e) {
                //   debugPrint(e.message);
                // }
              },
              child: Text('log out'),
              style: ButtonStyle(),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savethem/pages/login_page.dart';
import '../main.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Settings Screen', style: TextStyle(fontSize: 40)),
            ElevatedButton(
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
              child: Text('log out'),
            )
          ],
        ),
      ),
    );
  }
}

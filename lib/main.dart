import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/view/app/view_log/splash_screen.dart';
import 'package:login/view/user_auth/view_pages/LoginPage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCh8dcstj1onMbjAD4PeW3V5aDYfuaHgPQ",
            appId: "1:482367260628:web:1a68b24690e25c1d923841",
            messagingSenderId: "482367260628",
            projectId: "login-2a3ff"));
  }
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Login With Firebase',
        home: SplashScreen(
          child: LoginPage(),
        ));
  }
}

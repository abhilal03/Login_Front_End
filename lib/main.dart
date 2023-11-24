import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tourism/firebase_options.dart';
import 'package:tourism/pages/login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tourism Guide',
      home: LoginPage(),
    );
  }
}

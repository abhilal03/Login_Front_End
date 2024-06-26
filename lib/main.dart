import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism/controller/user_controller.dart';
import 'package:tourism/pages/login_page.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
          lazy: false,
        ),
      ],
      child: const App(),
    ),
  );
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

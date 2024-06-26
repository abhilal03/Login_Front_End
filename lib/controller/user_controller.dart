import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourism/pages/home.dart';
import 'package:tourism/pages/login_page.dart';
import 'package:tourism/widgets/custom_alerts.dart';

class UserProvider extends ChangeNotifier {
  // String baseUrl = "http://10.11.2.184:3000/";
  String baseUrl = "http://10.11.2.236:4000/";
  bool isUserRegistering = false;
  Future<void> userRegistration(
      {required String email,
      required String password,
      required String name,
      required String lastName,
      required BuildContext context}) async {
    Map<String, dynamic> data = {
      'email': email,
      'name': name,
      'ulastName': lastName,
      'password': password
    };
    try {
      isUserRegistering = true;
      notifyListeners();
      final response = await http.post(
        Uri.parse(baseUrl + "signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        CustomAlert.successMessage("User created successfully", context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      } else {
        Map<String, dynamic> result = jsonDecode(response.body);
        CustomAlert.warningMessage(result['message'], context);
      }
    } catch (e) {
      print('error occured $e');
    } finally {
      isUserRegistering = false;
      notifyListeners();
    }
  }

  bool isUserLogining = false;

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    Map<String, dynamic> data = {'email': email, 'password': password};
    try {
      isUserLogining = true;
      notifyListeners();
      final response = await http.post(
        Uri.parse(baseUrl + "signin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        CustomAlert.errorMessage("Invalid Username or password", context);
        //Map<String, dynamic> result = jsonDecode(response.body);
        //CustomAlert.errorMessage(result['sdcfdsmessage'], context);
      }
    } catch (e) {
      print('error occured $e');
    } finally {
      isUserRegistering = false;
      notifyListeners();
    }
  }
}

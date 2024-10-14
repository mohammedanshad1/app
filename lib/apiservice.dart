import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ApiService _apiService = ApiService();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String mobile = _mobileController.text;
    String password = _passwordController.text;

    bool success = await _apiService.userLogin(mobile, password);
    if (success) {
      // Handle successful login (e.g., navigate to another page)
      print('Login successful');
    } else {
      // Show error message
      print('Login failed');
    }
  }

  void _register() async {
    String name = 'Sathiya'; // Replace with user input
    String email = 'sathyab@mdqualityapps.com'; // Replace with user input
    String mobile = _mobileController.text;
    String password = _passwordController.text;

    bool success =
        await _apiService.userRegister(name, email, mobile, password);
    if (success) {
      // Handle successful registration (e.g., navigate to another page)
      print('Registration successful');
    } else {
      // Show error message
      print('Registration failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiService {
  final String baseUrl = "https://mdqualityapps.in/API/loginapi/";

  Future<bool> userLogin(String mobile, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}user_login'),
      body: {
        'userMobile': mobile,
        'userPassword': password,
      },
    );

    if (response.statusCode == 200) {
      // Handle the successful response here (for example, you might want to parse JSON)
      var jsonResponse = json.decode(response.body);
      // Process the response as needed
      return true; // Return true if login is successful
    } else {
      // Handle error
      print('Failed to login: ${response.statusCode}');
      return false;
    }
  }

  Future<bool> userRegister(
      String name, String email, String mobile, String password) async {
    final response = await http.post(
      Uri.parse('${baseUrl}user_register'),
      body: {
        'userName': name,
        'userMail': email,
        'userMobile': mobile,
        'userPassword': password,
      },
    );

    if (response.statusCode == 200) {
      // Handle the successful response here
      var jsonResponse = json.decode(response.body);
      // Process the response as needed
      return true; // Return true if registration is successful
    } else {
      // Handle error
      print('Failed to register: ${response.statusCode}');
      return false;
    }
  }
}

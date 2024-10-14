import 'package:app/model/signup_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpViewModel extends ChangeNotifier {
  bool isLoading = false;
  String message = '';

  Future<void> registerUser(String userName, String userMail, String userMobile, String userPassword) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse("https://mdqualityapps.in/API/loginapi/user_register");
    
    try {
      final response = await http.post(
        url,
        body: {
          'userName': userName,
          'userMail': userMail,
          'userMobile': userMobile,
          'userPassword': userPassword,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final signUpModel = SignUpModel.fromJson(data);

        message = signUpModel.message;
      } else {
        message = "Registration failed";
      }
    } catch (e) {
      message = "Error: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

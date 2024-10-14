import 'package:app/model/signup_model.dart';
import 'package:app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/view/login_view.dart'; 

class SignUpViewModel extends ChangeNotifier {
  bool isLoading = false;
  String message = '';

  Future<void> registerUser(BuildContext context, String userName,
      String userMail, String userMobile, String userPassword) async {
    isLoading = true;
    notifyListeners();

    final url =
        Uri.parse("https://mdqualityapps.in/API/loginapi/user_register");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
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

        CustomSnackBar.show(
          context,
          message: message,
          backgroundColor: signUpModel.error ? Colors.red : Colors.green,
          icon: signUpModel.error ? Icons.error : Icons.check_circle,
        );

     
        if (!signUpModel.error) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginView()),
          );
        }
      } else {
        message = "Registration failed";
        CustomSnackBar.show(
          context,
          message: message,
          backgroundColor: Colors.red,
          icon: Icons.warning,
        );
      }
    } catch (e) {
      message = "Network error";
      CustomSnackBar.show(
        context,
        message: message,
        backgroundColor: Colors.orange,
        icon: Icons.wifi_off,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

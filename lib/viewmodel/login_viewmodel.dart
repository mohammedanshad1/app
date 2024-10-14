import 'dart:convert';
import 'package:app/model/login_model.dart';
import 'package:app/view/homescreen_view.dart';
import 'package:app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginViewModel with ChangeNotifier {
  bool isLoading = false;
  static const String loginUrl =
      "https://mdqualityapps.in/API/loginapi/user_login";

  Future<void> login(
      BuildContext context, String userMobile, String userPassword) async {
    isLoading = true;
    notifyListeners();

    try {
      final Map<String, String> payload = {
        "userMobile": userMobile,
        "userPassword": userPassword,
      };

      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: payload,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final loginResponse = LoginModel.fromJson(responseData);
        print(responseData);

        if (loginResponse.error) {
          CustomSnackBar.show(
            context,
            message: loginResponse.message,
            backgroundColor: Colors.red,
            icon: Icons.error,
          );
        } else {
          CustomSnackBar.show(
            context,
            message: "Login successful!",
            backgroundColor: Colors.green,
            icon: Icons.check,
          );

      
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreenView(),
            ),
          );
        }
      } else {
        CustomSnackBar.show(
          context,
          message: "An error occurred. Please try again.",
          backgroundColor: Colors.red,
          icon: Icons.error,
        );
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        message: "An error occurred: ${e.toString()}",
        backgroundColor: Colors.red,
        icon: Icons.error,
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

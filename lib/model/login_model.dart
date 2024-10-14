

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    String message;
    bool error;

    LoginModel({
        required this.message,
        required this.error,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
    };
}

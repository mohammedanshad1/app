
import 'dart:convert';

SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
    String message;
    bool error;

    SignUpModel({
        required this.message,
        required this.error,
    });

    factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        message: json["message"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
    };
}

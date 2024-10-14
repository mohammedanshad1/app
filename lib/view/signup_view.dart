import 'package:app/constants/apptypography.dart';
import 'package:app/utils/responsive.dart';
import 'package:app/viewmodel/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignUpView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signUpViewModel = Provider.of<SignUpViewModel>(context);
    final responsive = context.responsive;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: AppTypography.bold.copyWith(fontSize: responsive.sp(18)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: AppTypography.regular.copyWith(fontSize: responsive.sp(14)),
              ),
            ),
            SizedBox(height: responsive.hp(2)),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: AppTypography.regular.copyWith(fontSize: responsive.sp(14)),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: responsive.hp(2)),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(
                labelText: 'Mobile',
                labelStyle: AppTypography.regular.copyWith(fontSize: responsive.sp(14)),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: responsive.hp(2)),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: AppTypography.regular.copyWith(fontSize: responsive.sp(14)),
              ),
              obscureText: true,
            ),
            SizedBox(height: responsive.hp(4)),
            signUpViewModel.isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      signUpViewModel.registerUser(
                        nameController.text,
                        emailController.text,
                        mobileController.text,
                        passwordController.text,
                      );
                    },
                    child: Text(
                      "Register",
                      style: AppTypography.medium.copyWith(fontSize: responsive.sp(16)),
                    ),
                  ),
            SizedBox(height: responsive.hp(3)),
            if (signUpViewModel.message.isNotEmpty)
              Text(
                signUpViewModel.message,
                style: AppTypography.regular.copyWith(
                  fontSize: responsive.sp(14),
                  color: signUpViewModel.message.contains("success") ? Colors.green : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

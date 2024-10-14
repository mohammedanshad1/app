import 'package:app/constants/apptypography.dart';
import 'package:app/utils/responsive.dart';
import 'package:app/view/signup_view.dart';
import 'package:app/viewmodel/login_viewmodel.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final responsive = context.responsive;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: responsive.wp(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: responsive.hp(10)),
            Text(
              'Login',
              style: AppTypography.bold.copyWith(fontSize: responsive.sp(24)),
            ),
            SizedBox(height: responsive.hp(5)),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(
                labelText: 'Mobile Number',
                prefixIcon: Icon(Icons.phone),
                labelStyle: AppTypography.regular.copyWith(
                  fontSize: responsive.sp(14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              keyboardType: TextInputType.phone,
              style: AppTypography.regular,
            ),
            SizedBox(height: responsive.hp(2)),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
                labelStyle: AppTypography.regular.copyWith(
                  fontSize: responsive.sp(14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
              style: AppTypography.regular,
            ),
            SizedBox(height: responsive.hp(4)),
            Consumer<LoginViewModel>(
              builder: (context, loginViewModel, child) {
                return CustomButton(
                  buttonName: "Login",
                  onTap: loginViewModel.isLoading
                      ? () {}
                      : () {
                          String userMobile = _mobileController.text.trim();
                          String userPassword = _passwordController.text.trim();
                          if (userMobile.isNotEmpty &&
                              userPassword.isNotEmpty) {
                            loginViewModel.login(
                                context, userMobile, userPassword);
                          } else {
                            CustomSnackBar.show(
                              context,
                              message: "Please fill in all fields",
                              backgroundColor: Colors.orange,
                              icon: Icons.warning,
                            );
                          }
                        },
                  buttonColor: Colors.blue,
                  height: responsive.hp(6),
                  width: double.infinity,
                );
              },
            ),
            SizedBox(height: responsive.hp(3)),
            TextButton(
              onPressed: () {
                // Navigate to the Register screen
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignUpView()));
              },
              child: Text(
                "Don't have an account? Register",
                style: AppTypography.regular.copyWith(
                  fontSize: responsive.sp(14),
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

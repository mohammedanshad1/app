import 'package:app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/constants/apptypography.dart';
import 'package:app/utils/responsive.dart';
import 'package:app/view/login_view.dart';
import 'package:app/viewmodel/signup_viewmodel.dart';

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
        centerTitle: true,
        title: Text(
          "Register",
          style: AppTypography.bold.copyWith(fontSize: responsive.sp(18)),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
        child: Center(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(maxWidth: 400), // Limit width for centering
            child: Column(
              children: [
                SizedBox(height: responsive.hp(2)),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: AppTypography.regular.copyWith(
                      fontSize: responsive.sp(14),
                    ),
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: responsive.hp(2)),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: AppTypography.regular.copyWith(
                      fontSize: responsive.sp(14),
                    ),
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: responsive.hp(2)),
                TextField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    labelStyle: AppTypography.regular.copyWith(
                      fontSize: responsive.sp(14),
                    ),
                    prefixIcon: Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: responsive.hp(2)),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: AppTypography.regular.copyWith(
                      fontSize: responsive.sp(14),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: responsive.hp(4)),
                signUpViewModel.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        buttonName: "Register",
                        onTap: () {
                          signUpViewModel.registerUser(
                            context,
                            nameController.text,
                            emailController.text,
                            mobileController.text,
                            passwordController.text,
                          );
                        },
                        buttonColor: Colors.blue,
                        height: responsive.hp(6),
                        width: double.infinity,
                      ),
                SizedBox(height: responsive.hp(2)),
                CustomButton(
                  buttonName: "Login",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                  buttonColor: Colors.grey,
                  height: responsive.hp(6),
                  width: double.infinity,
                ),
                SizedBox(height: responsive.hp(3)),
                if (signUpViewModel.message.isNotEmpty)
                  Center(
                    child: Text(
                      signUpViewModel.message,
                      style: AppTypography.regular.copyWith(
                        fontSize: responsive.sp(14),
                        color: signUpViewModel.message.contains("success")
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

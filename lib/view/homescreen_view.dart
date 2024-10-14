import 'package:app/view/login_view.dart';
import 'package:app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        // Remove the back button by setting automaticallyImplyLeading to false
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Add some space
            CustomButton(
              buttonName: "Logout",
              onTap: () {
                // Navigate to the LoginView when tapped
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
              buttonColor: Colors.red, // You can change the color as needed
              height: 40, // Set the height of the button
              width: 150, // Set the width of the button
            ),
          ],
        ),
      ),
    );
  }
}

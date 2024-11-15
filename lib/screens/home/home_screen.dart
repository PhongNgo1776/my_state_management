import 'package:flutter/material.dart';
import 'package:my_state_management/screens/user/presentation/widgets/user_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserScreen(
                  userRole: 'Buyer',
                  isBuyer: true,
                ),
              ),
            );
          },
          child: const Text('Open Buyer screen'),
        ),
      ),
    );
  }
}

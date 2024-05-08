import 'package:flutter/material.dart';
import 'package:flutter_local_auth_app/homepage.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: const Text("Click here to navigate and check balance")),
      ),
    );
  }
}

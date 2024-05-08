import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAuthenticated = false;
  final LocalAuthentication auth = LocalAuthentication();
  //auth method
  Future<void> authMethod() async {
    if (!isAuthenticated) {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

      if (canAuthenticateWithBiometrics) {
        try {
          final bool didAuthenticate = await auth.authenticate(
              localizedReason: 'Please authenticate to check balance',
              options: const AuthenticationOptions(biometricOnly: true));

          setState(() {
            isAuthenticated = didAuthenticate;
          });
        } catch (e) {
          log('Error while authenticating $e');
        }
      }
    } else {
      setState(() {
        isAuthenticated = false;
      });
    }
  }

  @override
  void initState() {
    authMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Account Balance",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              isAuthenticated ? "\$45,789.34" : "***********",
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authMethod();
        },
        child: Icon(isAuthenticated ? Icons.lock_open : Icons.lock),
      ),
    );
  }
}

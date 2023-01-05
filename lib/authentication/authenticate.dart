import 'package:flutter/material.dart';
import 'package:mytest/authentication/sign_in.dart';
import 'package:mytest/authentication/register.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showLoginPage = true;

  void toggleView() {
    setState(() => showLoginPage = !showLoginPage);
  }

  @override
  Widget build(BuildContext context) {
    // Always true
    if (showLoginPage) {
      // Toggle on sign in page
      return SignIn(
        toggleView: toggleView,
      );
    } else {
      // Toggle on register page
      return Register(
        toggleView: toggleView,
      );
    }
  }
}

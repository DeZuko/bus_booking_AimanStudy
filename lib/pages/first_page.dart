import 'package:flutter/material.dart';
import 'package:mytest/authentication/shared_preferences.dart';
import 'package:mytest/authentication/authenticate.dart';
import 'package:mytest/pages/main_page/homepage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool? isLogin = Spreferences.getIsLogin();

  @override
  Widget build(BuildContext context) {
    // If the session has logged user, go to HomePage()
    if (isLogin != null && isLogin == true) {
      return const HomePage();
    }
    // Otherwise, go to sign-in page
    else {
      return const Authentication();
    }
  }
}

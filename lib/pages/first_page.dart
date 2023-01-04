import 'package:flutter/material.dart';
import 'package:mytest/pages/authentication/shared_preferences.dart';
import 'package:mytest/pages/authentication/authenticate.dart';
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
    if (isLogin != null && isLogin == true) {
      return const HomePage();
    } else {
      return const Authentication();
    }
  }
}

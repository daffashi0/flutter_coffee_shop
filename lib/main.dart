import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/screens/home_screen.dart';
import 'package:flutter_coffee_shop/screens/login_screen.dart';
import 'package:flutter_coffee_shop/services/user_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserHelper().getToken();
    if (token != null) {
      setState(() {
        page = const HomeScreen();
      });
    } else {
      setState(() {
        page = const LoginScreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Coffee Shop',
      debugShowCheckedModeBanner: false,
      home: page,
    );
  }
}

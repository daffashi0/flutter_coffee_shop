import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/bloc/product_bloc.dart';
import 'package:flutter_coffee_shop/components/appBar.dart';
import 'package:flutter_coffee_shop/components/card.dart';
import 'package:flutter_coffee_shop/models/login.dart';
import 'package:flutter_coffee_shop/models/product.dart';
import 'package:flutter_coffee_shop/screens/home_screen.dart';
import 'package:flutter_coffee_shop/screens/register_screen.dart';
import 'package:flutter_coffee_shop/services/user_helper.dart';

import '../bloc/user_bloc.dart';
import '../models/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerUsername.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: Text(widget.title ?? 'Login'),
        appBar: AppBar(),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Stack(
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: controllerUsername,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Username'),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) return "Username tidak boleh kosong";
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    controller: controllerPassword,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Password'),
                    ),
                    validator: (val) {
                      if (val!.isEmpty) return "Passowrd tidak boleh kosong";
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => onSubmit(),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(
                          title: 'Register',
                        ),
                      ),
                    ),
                    child: const Text('Belum punya akun? Register disini'),
                  ),
                ],
              ),
            ),
            if (isLoading == true)
              Container(
                  alignment: Alignment.center,
                  color: Color(0x78ffffff),
                  child: const CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }

  void onSubmit() async {
    var validate = formKey.currentState!.validate();
    if (validate) {
      doLogin();
    }
  }

  void doLogin() async {
    setState(() {
      isLoading = true;
    });
    await UserBloc.login(
      username: controllerUsername.text,
      password: controllerPassword.text,
    ).then((value) async {
      await UserHelper().setToken(value.token.toString());
      await UserHelper().setUserId(int.parse(value.userId.toString()));
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_coffee_shop/bloc/user_bloc.dart';
import 'package:flutter_coffee_shop/components/appBar.dart';
import 'package:flutter_coffee_shop/models/register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final controllerNama = TextEditingController();
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controllerNama.dispose();
    controllerUsername.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: Text(widget.title),
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
                      controller: controllerNama,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Nama'),
                      ),
                      validator: (val) {
                        if (val!.isEmpty) return "Nama tidak boleh kosong";
                      },
                    ),
                    const SizedBox(height: 20),
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
                        if (val!.isEmpty) return "Password tidak boleh kosong";
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => onSubmit(),
                      child: const Text('Register'),
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
        ));
  }

  void onSubmit() async {
    var validate = formKey.currentState!.validate();
    if (validate) {
      doRegister();
    }
  }

  void doRegister() async {
    setState(() {
      isLoading = true;
    });
    Register register = await UserBloc.register(
      nama: controllerNama.text,
      username: controllerUsername.text,
      password: controllerPassword.text,
    );

    if (register != null) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Akun terdaftar"),
        backgroundColor: Colors.blueAccent,
      ));
      Navigator.pop(context);
    }
  }
}

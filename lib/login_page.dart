import 'package:flutter/material.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/signup_page.dart';
import 'package:todo_app/database_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State {
  bool _obscureText = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  void _login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    final user = await _databaseHelper.getUser(email, password);

    if (user != null && user['password'] == password) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful 💪💪')),
      );
    } else {
      // Login failed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not Found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: const Text("Login Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _fromKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/images/loginpageimg.png",
                height: 120,
                width: 120,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: "Email",
                    hintText: "Enter Email"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Email";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: ".",
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "Password",
                  hintText: "Enter Password",
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter Password";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 250,
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 250, 207, 79))),
                    onPressed: () {
                      bool loginValidated = _fromKey.currentState!.validate();
                      _login();

                      if (loginValidated) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Login Successful")),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdvanceTODO()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login Failed")));
                      }
                    },
                    child: const Text("Login")),
              ),
              Container(
                padding: const EdgeInsets.only(left: 70, top: 10),
                  child: Column(
                children: [
                  Row(
                    children: [
                      const Text("Don't have an account?"),
                      const SizedBox(width: 10),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()));
                          },
                          child: const Text("Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                          )),
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

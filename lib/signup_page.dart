import 'package:flutter/material.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/login_page.dart';
import 'package:todo_app/main.dart';

class Signup extends StatefulWidget{
  const Signup({super.key});

  @override 
  State createState()=> _SignupState();
}

class _SignupState extends State{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      
    body:Container(
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(colors: [
      //     Color.fromRGBO(197, 87, 140, 1),
      //     Color.fromRGBO(144, 69, 176, 1)
      //   ]),
      // ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                obscuringCharacter: '.',
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffix: const Icon(Icons.remove_red_eye_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffix: const Icon(Icons.remove_red_eye_outlined)
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Container(
                width: 20,
                padding: const EdgeInsets.only(top: 2, bottom: 2),
                child: ElevatedButton(
                  onPressed: () async {
                    bool signupValidated = _formKey.currentState!.validate();

                    if (signupValidated) {
                      await _databaseHelper.insertUsers(
                          emailController.text, passwordController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("User Created Successfully")));
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdvanceTODO()),
                        );

                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Signup Failed")));
                    }
                  },
                  child: const Text("Sign Up"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 70, top: 10),
              child:Column(
                children: [
                  Row(
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(width: 10),
                      GestureDetector(
                        
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                        },
                        child: const Text("Sign in",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        ),
                      )
                    ],
                  )
                ],
              )

            ),
              
            ],
          ),
        ),
      ),
    ),
    );
  }
}
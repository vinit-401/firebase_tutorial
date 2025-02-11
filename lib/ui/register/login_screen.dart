import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/uitls/util.dart';

import '../../controllers/controller.dart';

GlobalKey<FormState> _loginFormKey = GlobalKey();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.green.shade50,
            ],
          )),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: greenGradient),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.teal,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value != null) {
                          if (value.trim().length < 3) {
                            return 'Minimum 3 Characters are required';
                          } else if (value.isEmpty) {
                            return 'required field';
                          }
                        }
                        return null;
                      },
                      decoration: decoration('Email')),
                  TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value != null) {
                          if (value.trim().length < 6) {
                            return 'Minimum 6 Characters are required';
                          } else if (value.isEmpty) {
                            return 'required field';
                          }
                        }
                        return null;
                      },
                      decoration: decoration('Password')),
                  TextButton(
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        UserCredential? data = await FirebaseController.loginUser(
                            _emailController.text.trim(), _passwordController.text.trim());
                        _passwordController.clear();
                        _emailController.clear();
                        if (data != null && data.user != null) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text('Login'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

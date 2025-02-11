import 'package:flutter/material.dart';
import 'package:untitled/controllers/controller.dart';
import 'package:untitled/ui/register/login_screen.dart';
import 'package:untitled/uitls/util.dart';

GlobalKey<FormState> _signUpFormKey = GlobalKey();

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: greenGradient
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 15,
                children: [
                  Text(
                    'Sign Up',
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
                      decoration:decoration('Email')),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ));
                          },
                          child: Text('Login')),
                      TextButton(
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {
                            FirebaseController.createUser(_emailController.text.trim(), _passwordController.text.trim());
                            _passwordController.clear();
                            _emailController.clear();
                          }
                        },
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

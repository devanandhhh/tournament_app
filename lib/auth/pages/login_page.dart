import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/auth/components/my_button.dart';
import 'package:tournament_creator/auth/components/my_validator.dart';
import 'package:tournament_creator/screens/other/sample.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';
import 'package:tournament_creator/screens/home_Screen/reuse_widgets/refactoring.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

//sign method
  void signInUserIn() async {
    if (formKey.currentState!.validate()) {
      try {

        //checking user already exist
        
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackbarDecoraction()
            .kSnakbar(text: 'Sucessfully Logged In', col: Colors.green[300]));
      } catch (e) {

        log('failed to Login $e');
        String errorMessage = "User not Found";
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackbarDecoraction().kSnakbar(
            text: errorMessage,
            col: Colors.red[300],
          ),
        );
      }
    }
  }
  //function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                sizedbox70(), sizedbox30(),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                sizedbox30(), sizedbox30(), sizedbox10(),
                Text(
                  'Welcome back,You\'ve been Missed!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                sizedbox30(), sizedbox30(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    //   validator: Validator.validateEmail,
                    validator: Validator.validateEmail1,
                    controller: emailController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: false,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        fillColor: Colors.yellow[100],
                        filled: true,
                        hintText: 'Email'),
                  ),
                ),
                //password textfield
                sizedbox30(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    //   validator: Validator.validateEmail,
                    validator: Validator.validatePassword1,
                    controller: passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        fillColor: Colors.yellow[100],
                        filled: true,
                        hintText: 'Password'),
                  ),
                ),
                sizedbox30(),
                MyButton(
                  onTap: signInUserIn,
                  text: 'LogIn ',
                ),
                sizedbox30(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            'Or continue',
                            style: TextStyle(color: Colors.grey[700]),
                          )),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ))
                    ],
                  ),
                ),
                sizedbox30(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: signInUserIn,
                      child: GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register Now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )
                //sign in button
              ],
            ),
          ),
        ),
      ),
      //])
    );
  }
}

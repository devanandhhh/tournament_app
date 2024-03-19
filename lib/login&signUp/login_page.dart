import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tournament_creator/login&signUp/components/my_button.dart';
import 'package:tournament_creator/login&signUp/components/my_validator.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  LoginPage({super.key, required this.onTap});

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
      // sign user in method
     
      //sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
       

        // navigatorPOP(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Sucessfully Logged In'),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green[400],
        ));
      } catch (e) {
        print('failed to Login $e');
        String errorMessage = "User not Found";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red[400],
          ),
        );
      }
    }
  
    //navigatorPOP(context);
  }
  //function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow[100],
        body:
      
          SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                  
                    const SizedBox(
                      height: 110,
                    ),
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Welcome back,You\'ve been Missed!',
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        //   validator: Validator.validateEmail,
                        validator: Validator.validateEmail1,
                        controller: emailController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        obscureText: false,
                        decoration: InputDecoration(
                            enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder:  OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            fillColor: Colors.yellow[100],
                            filled: true,
                            hintText: 'Email'),
                      ),
                    ),
                    //password textfield
                    const SizedBox(
                      height: 25,
                    ),
                   
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
                    const SizedBox(
                      height: 25,
                    ),
                    MyButton(
                      onTap: signInUserIn,
                      text: 'LogIn ',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
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
                    const SizedBox(
                      height: 25,
                    ),
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
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
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

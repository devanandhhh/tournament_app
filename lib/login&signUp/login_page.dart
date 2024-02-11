import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/login&signUp/components/my_texfield.dart';
import 'package:tournament_creator/login&signUp/components/my_button.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  LoginPage({super.key,required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

//sign method
  void signInUserIn() async {
    // sign user in method
    showDialog(context: context, builder: (context){
      return const Center(child: CircularProgressIndicator(),);
    });
    //sign in
 
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text);
        navigatorPOP(context);
    // }on FirebaseAuthException catch(e){
    //   if(e.code=='user-not-found'){
    //     //show error 
    //     print('user not found');

    //   }else if(e.code=='wrong-password'){

    //   }
    // }
        //navigatorPOP(context);
  }
  //function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SafeArea(
        child: SingleChildScrollView(
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
              SizedBox(
                height: 25,
              ),
              //user textfield
              MyTextfield(
                controller: emailController,
                hinttext: 'Email',
                obscureText: false,
              ),
              //password textfield
              SizedBox(
                height: 25,
              ),
              MyTextfield(
                controller: passwordController,
                hinttext: 'Password',
                obscureText: true,
              ),
              SizedBox(
                height: 25,
              ),
              MyButton(
                onTap: signInUserIn,
                text: 'Sign In',
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
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
                    child:  GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
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
    );
  }

  
}

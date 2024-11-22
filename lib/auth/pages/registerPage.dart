import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/auth/components/my_texfield.dart';
import 'package:tournament_creator/auth/components/my_button.dart';
import 'package:tournament_creator/auth/components/my_validator.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';

class Register_page extends StatefulWidget {
  final Function()? onTap;

  Register_page({super.key, required this.onTap});

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final userNameController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final formKey =GlobalKey<FormState>();
// final user = FirebaseAuth.instance.currentUser!;
//sign method
  void signInUserUp() async {
if(formKey.currentState!.validate()){
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    //sign Up
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
         ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('sucessfully entered')));
           // DocumentReference documentReference=
        await FirebaseFirestore.instance.collection('users').add({
          'email': emailController.text,
          'userName': userNameController.text,
          'password': passwordController.text,
          'profile':null  
        });
            //  navigatorPOP(context);

      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('password not Done')));
      }
     // navigatorPOP(context);
    } on FirebaseAuthException catch (e) {
      print('error during $e');
      // ignore: use_build_context_synchronously
      navigatorPOP(context);
      // if (e.code == 'user-not-found') {
      //   //show error
      // } else if (e.code == 'wrong-password') {}
    }
}


    // sign user in method
   
  }
  //function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body:
      //  Stack(
      //   fit: StackFit.expand,
      //   children: [
      //     SizedBox(
      //        height: 200,
      //         width: 300,
      //         child: Image.asset(
      //           'assets/demo.jpg', 
      //           fit: BoxFit.cover, 
      //         )
      //     ),
         SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Icon(
                      Icons.lock,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Let's Create An Account for Youhh!",
                      style: TextStyle(color: Colors.grey[700], fontSize: 16),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    MyTextfield(
                      validateOntap: Validator.validateName,
                      
                      controller: userNameController,
                      hinttext: 'User Name',
                      obscureText: false,
                    ),
                    //password textfield
                    SizedBox(
                      height: 25,
                    ),
                    //user textfield
                    MyTextfield(
                      controller: emailController,
                      validateOntap: Validator.validateEmail1,
                      hinttext: 'Email',
                      obscureText: false,
                    ),
                    //password textfield
                    SizedBox(
                      height: 25,
                    ),
                    MyTextfield(
                      validateOntap: Validator.validatePassword1,
                      controller: passwordController,
                      hinttext: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    MyTextfield(
                      validateOntap: Validator.validatePassword1,
                      controller: confirmpasswordController,
                      hinttext: 'Confirm Password',
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    MyButton(
                      onTap: signInUserUp,
                      text: 'Sign Up',
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
                          'Already Have an account?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Login Now',
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
       // ),]
      ),
    );
  }
}

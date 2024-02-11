import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tournament_creator/login&signUp/components/my_texfield.dart';
import 'package:tournament_creator/login&signUp/components/my_button.dart';
import 'package:tournament_creator/screens/addNotes/widgets/refactoring.dart';

class Register_page extends StatefulWidget {
  final Function()? onTap;

  Register_page({super.key,required this.onTap});

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
final userNameController=TextEditingController();
final confirmpasswordController=TextEditingController();
// final user = FirebaseAuth.instance.currentUser!;
//sign method
  void signInUserUp() async {
    // sign user in method
    showDialog(context: context, builder: (context){ 
      return const Center(child: CircularProgressIndicator(),);
    });
    //sign Up
    try{
     if(passwordController.text==confirmpasswordController.text){
      
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('sucessfully entered')));
              await FirebaseFirestore.instance.collection('users').add({
                'email':emailController.text,
                'userName':userNameController.text,
                'password':passwordController.text,
               
              });

     }
     else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error')));
     }
        navigatorPOP(context);
    }on FirebaseAuthException catch(e){
      navigatorPOP(context);
      if(e.code=='user-not-found'){
        //show error 
         

      }else if(e.code=='wrong-password'){

      }
    }
       
  }
  //function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 40 ,
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
                  controller:userNameController,
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
                 MyTextfield(
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
                      child:  GestureDetector(
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
    );
  }

  
}

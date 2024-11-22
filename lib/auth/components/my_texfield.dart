import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
final String hinttext;
final bool obscureText;
String? Function(String?)? validateOntap;
   MyTextfield({super.key,required this.controller,required this.hinttext,required this.obscureText,required this.validateOntap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    validator: validateOntap,
                    controller: controller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      
                        enabledBorder:const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder:const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black)),
                        fillColor: Colors.yellow[100],
                        filled: true,hintText: hinttext),
                        
                  ),
                );
  }
}
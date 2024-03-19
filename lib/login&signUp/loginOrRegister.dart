import 'package:flutter/material.dart';
import 'package:tournament_creator/login&signUp/login_page.dart';
import 'package:tournament_creator/login&signUp/registerPage.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLoginPage=true;

togglepages(){
  setState(() {
    
    showLoginPage=!showLoginPage;
  });
}

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(onTap: togglepages);
    }else{
      return Register_page(onTap:togglepages,);
    }
  }
}
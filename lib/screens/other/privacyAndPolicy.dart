import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbardecorations(name: 'Privacy & Policy '),
      backgroundColor: Colors.yellow[100],
      body:const SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              '''
At Tournament Creator, your privacy is our priority. We want you to feel confident and secure while using our app.
        
Here's a brief overview of our commitment to your privacy:
        
Data Storage: We securely store the data you provide within the app to ensure smooth tournament management.
        
Data Protection: We promise not to share your data with any third parties for marketing purposes. Your information is kept strictly confidential.
        
Your trust means everything to us. If you have any questions or concerns about how we handle your data, please don't hesitate to reach out.
        
Thank you for choosing Tournament Creator for your tournament organization needs.
        ''',
              style:TextStyle(fontSize: 15) ,
            ),
          )
        ],
      )),
    );
  }
}

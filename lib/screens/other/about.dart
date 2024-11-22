import 'package:flutter/material.dart';
import 'package:tournament_creator/screens/create_tounament/reuse_widgets/reuse_widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      appBar: appbardecorations(name: 'About Us '),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                '''Welcome to our App, the creator of the Tournament Creator app.
                  
In this Application, we are passionate about providing innovative solutions for tournament organization. Our goal is to simplify the process of creating and managing tournaments, making it easier for sports enthusiasts, event organizers, and gamers alike to bring their competitions to life.
                  
Our Mission
                  
We strive to empower users with intuitive tools that streamline the tournament planning process. Whether you're hosting a local soccer tournament, an eSports competition, or a board game showdown with friends, our app is designed to help you effortlessly manage every aspect of your event.
                  
Why Choose Tournament Creator?
                  
User-Friendly Interface: Our app boasts a user-friendly interface that makes tournament creation and management accessible to all.
                  
Comprehensive Features: From team and player management to fixture creation and score updates, Tournament Creator offers a comprehensive suite of features to meet your needs.
                  
Privacy and Security: We prioritize the privacy and security of your data. Rest assured that your information is stored securely and will never be shared without your consent.
                  
Get in Touch
                  
We're here to support you every step of the way. If you have any questions, feedback, or suggestions, please don't hesitate to reach out to our team.
                  
Thank you for choosing Tournament Creator. Let's make your next tournament a success together!''',
                style: TextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

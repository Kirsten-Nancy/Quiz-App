import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Welcome to Quiz App'),
              Image.asset("assets/images/quiz-splash.png"),
              ElevatedButton(
                onPressed: () {},
                child: Text('Continue'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

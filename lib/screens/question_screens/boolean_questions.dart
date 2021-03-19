import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/services/scoreprovider.dart';
import 'package:quiz_app_flutter/widgets/question_widget.dart';
import 'package:quiz_app_flutter/widgets/result_widget.dart';

import '../../models/question_model.dart';

class BooleanQuestionScreen extends StatefulWidget {
  final List<Question> questions;

  BooleanQuestionScreen(this.questions);

  @override
  _BooleanQuestionScreenState createState() => _BooleanQuestionScreenState();
}

class _BooleanQuestionScreenState extends State<BooleanQuestionScreen> {
  int questionIndex = 0;
  PageController _pageController = PageController();

  Widget _buildButton(BuildContext context, String label) {
    return ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.pinkAccent,
          textStyle: TextStyle(
            color: Color(0xFF2f243a),
          ),
        ),
        onPressed: () => onPress(label),
        child: Text(
          label,
          style: TextStyle(fontSize: 22.0),
        ),
      ),
    );
  }

  void onPress(String answer) {
    if (answer == widget.questions[questionIndex].correctAnswer) {
      var score = context.read<Score>();
      score.increment();
    }
    setState(() {
      questionIndex++;
    });
    _pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.questions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: index == (widget.questions.length - 1)
              ? ResultsPage()
              : Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    QuestionWidget(widget, index),
                    SizedBox(
                      height: 100,
                    ),
                    _buildButton(context, 'True'),
                    SizedBox(
                      height: 20,
                    ),
                    _buildButton(context, 'False'),
                  ],
                ),
        );
      },
    );
  }
}

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/scoreprovider.dart';
import 'package:quiz_app_flutter/widgets/question_widget.dart';
import 'package:quiz_app_flutter/widgets/result_widget.dart';
import 'models/question_model.dart';

class MultipleQuestionChoiceScreen extends StatefulWidget {
  final List<Question> questions;

  const MultipleQuestionChoiceScreen(this.questions);

  @override
  _MultipleQuestionChoiceScreenState createState() =>
      _MultipleQuestionChoiceScreenState();
}

class _MultipleQuestionChoiceScreenState
    extends State<MultipleQuestionChoiceScreen> {
  List<String> answers = [];
  PageController _pageController = PageController();
  int index = 0;

  void checkAnswer(String ans) {
    if (ans == widget.questions[index].correct_answer) {
      var score = context.read<Score>();
      score.increment();
    }

    setState(() {
      index++;
    });
    _pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    return PageView.builder(
      itemBuilder: (context, index) {
        answers = [];
        answers.add(widget.questions[index].correct_answer);
        answers.addAll(widget.questions[index].incorrect_answers);
        answers.shuffle();
        print('answers: $answers');
        return index == widget.questions.length - 1
            ? ResultsPage()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    QuestionWidget(widget, index),
                    SizedBox(
                      height: 20,
                    ),
                    for (String answer in answers)
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        child: OutlineButton(
                          onPressed: () => checkAnswer(answer),
                          child: Text(unescape.convert(answer)),
                        ),
                      )
                  ],
                ),
              );
      },
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.questions.length,
    );
  }
}

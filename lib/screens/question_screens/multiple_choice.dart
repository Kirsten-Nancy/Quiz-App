import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/services/scoreprovider.dart';
import 'package:quiz_app_flutter/widgets/question_widget.dart';
import 'package:quiz_app_flutter/widgets/result_widget.dart';
import '../../models/question_model.dart';

class MultipleQuestionChoiceScreen extends StatefulWidget {
  final List<Question> questions;

  const MultipleQuestionChoiceScreen(this.questions);

  @override
  _MultipleQuestionChoiceScreenState createState() =>
      _MultipleQuestionChoiceScreenState();
}

class _MultipleQuestionChoiceScreenState
    extends State<MultipleQuestionChoiceScreen> {
  PageController _pageController = PageController();
  int index = 0;

  void checkAnswer(String ans) {
    if (ans == widget.questions[index].correctAnswer) {
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
        print(widget.questions[index].correctAnswer);
        print(index);
        return index == widget.questions.length
            ? ResultsPage()
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    QuestionWidget(widget, index),
                    SizedBox(
                      height: 20,
                    ),
                    for (String answer in widget.questions[index].answers)
                      Container(
                        height: 70,
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.greenAccent)),
                          onPressed: () => checkAnswer(answer),
                          child: Text(
                            unescape.convert(answer),
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 60,
                    ),
                    Container(
                      width: 120,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent),
                        onPressed: () {},
                        child: Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
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

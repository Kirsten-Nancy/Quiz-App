import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/models/question_model.dart';
import 'package:quiz_app_flutter/screens/question_screens/multiple_choice.dart';

class QuizScreen extends StatefulWidget {
  final int categoryId;
  QuizScreen(this.categoryId);
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Future<List<Question>> _questionData;

  @override
  void initState() {
    super.initState();
    _questionData = fetchQuestions();
  }

  Future<List<Question>> fetchQuestions() async {
    var response = await http.get(
        "https://opentdb.com/api.php?amount=10&category=${widget.categoryId}&type=multiple");
    if (response.statusCode == 200) {
      //returns a list of maps as well
      final jsonResponse = jsonDecode(response.body);

      var questionList = jsonResponse['results'] as List;
      List<Question> questions =
          questionList.map((question) => Question.fromJson(question)).toList();
      // for (var question in questions) {
      //   answers.add(question.correct_answer);
      //   answers.addAll(question.incorrect_answers);
      // }
      // print(answers);
      return questions;
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF141A33),
        body: FutureBuilder(
          future: _questionData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            } else if (snapshot.hasData) {
              // if (widget.type == 'boolean') {
              //   return BooleanQuestionScreen(snapshot.data);
              // } else {
              return MultipleQuestionChoiceScreen(snapshot.data);
              // }
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

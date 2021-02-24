import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/models/question_model.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/multiple_choice.dart';
import 'package:quiz_app_flutter/scoreprovider.dart';

import 'boolean_questions.dart';

class QuizScreen extends StatefulWidget {
  final int categoryId;
  final String type;
  QuizScreen(this.categoryId, this.type);
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

  // ignore: missing_return
  Future<List<Question>> fetchQuestions() async {
    var response = await http.get(
        "https://opentdb.com/api.php?amount=10&category=${widget.categoryId}&type=${widget.type}");
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
    print('type${widget.type}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text('Score: ${context.watch<Score>().score}'),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              context.read<Score>().reset();
              Navigator.of(context).pop();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Quit'),
            ),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: _questionData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          } else if (snapshot.hasData) {
            if (widget.type == 'boolean') {
              return BooleanQuestionScreen(snapshot.data);
            } else {
              return MultipleQuestionChoiceScreen(snapshot.data);
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

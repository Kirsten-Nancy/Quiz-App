import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/models/question_model.dart';
import 'package:quiz_app_flutter/scoreprovider.dart';
import 'home.dart';
import 'models/category_model.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Score(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF2f243a),
        ),
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> dropData = [];
  int selectedId;
  String questionType;
  @override
  void initState() {
    super.initState();
    this.getCategories();
  }

  Future<List<Category>> getCategories() async {
    var response = await http.get('https://opentdb.com/api_category.php');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["trivia_categories"] as List;
      List<Category> categories = [];
      for (var cat in data) {
        categories.add(Category.fromJson(cat));
      }
      print(categories[0].categoryName);
      setState(() {
        dropData = categories;
        print(data);
      });
      return categories;
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Trivia Quiz'),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Select Category'),
          SizedBox(
            height: 30,
          ),
          DropdownButton(
            disabledHint: Text('Loading categories'),
            hint: Text('General Knowledge'),
            items: dropData.map((category) {
              return DropdownMenuItem(
                child: Text(category.categoryName),
                value: category.id,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedId = value;
                print(selectedId);
              });
            },
            value: selectedId,
          ),
          SizedBox(
            height: 30,
          ),
          DropdownButton(
            hint: Text('Any Type'),
            items: [
              DropdownMenuItem(
                child: Text('True/False'),
                value: 'boolean',
              ),
              DropdownMenuItem(
                child: Text('Multiple'),
                value: 'multiple',
              ),
            ],
            value: questionType,
            onChanged: (value) {
              setState(() {
                questionType = value;
              });
            },
          ),
          Center(
            child: ElevatedButton(
              child: Text('Start quiz'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return QuizScreen(selectedId, questionType);
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}

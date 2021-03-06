import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app_flutter/services/data.dart';
import 'quiz_screen.dart';
import '../models/category_model.dart';
import 'package:flutter/material.dart';

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
    // this.getCategories();
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
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.greenAccent,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.greenAccent,
                expandedHeight: 80,
                floating: true,
                pinned: true,
                elevation: 0,
                flexibleSpace: Container(
                  child: Center(
                    child: Text(
                      'Choose Category',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF141A33),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                    ),
                  ),
                ),
              ),
              SliverGrid.count(
                crossAxisCount: 2,
                children: [
                  for (var category in categories)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return QuizScreen(category['id']);
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  category['image'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Text(
                                category['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              )
            ],
          )),
    );
  }
}

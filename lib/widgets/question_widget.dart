import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quiz_app_flutter/services/scoreprovider.dart';
import 'package:provider/provider.dart';

class QuestionWidget extends StatelessWidget {
  final parentWidget;
  final index;
  QuestionWidget(this.parentWidget, this.index);
  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${index + 1}/${parentWidget.questions.length}',
                style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  context.read<Score>().reset();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Quit',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Card(
            color: Colors.greenAccent,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  unescape.convert(parentWidget.questions[index].question),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

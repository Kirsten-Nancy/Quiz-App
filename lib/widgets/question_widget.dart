import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class QuestionWidget extends StatelessWidget {
  final parentWidget;
  final index;
  QuestionWidget(this.parentWidget, this.index);
  @override
  Widget build(BuildContext context) {
    var unescape = HtmlUnescape();
    return Column(
      children: [
        Text(
          'Question ${index + 1}/${parentWidget.questions.length}',
          style: TextStyle(fontSize: 24.0),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: Card(
            color: Color(0xFFc1bddb),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  unescape.convert(parentWidget.questions[index].question),
                  style: TextStyle(
                    color: Colors.black,
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

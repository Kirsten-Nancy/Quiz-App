import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_flutter/scoreprovider.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int score = Provider.of<Score>(context, listen: false).score;
    return Column(
      children: [
        Text(score.toString()),
        ElevatedButton.icon(
          onPressed: () {
            context.read<Score>().reset();
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.autorenew_rounded),
          label: Text('Restart Quiz'),
        )
      ],
    );
  }
}

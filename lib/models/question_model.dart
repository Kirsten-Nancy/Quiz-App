class Question {
  String category;
  String type;
  String difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;
  List<String> answers;

  Question(
      {this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.incorrectAnswers,
      this.answers});

  factory Question.fromJson(Map<String, dynamic> parsedJson) {
    var incorrectAnswersFromJson = parsedJson['incorrect_answers'];
    List<String> incorrectAnswersList = incorrectAnswersFromJson.cast<String>();
    return Question(
        category: parsedJson['category'],
        type: parsedJson['type'],
        difficulty: parsedJson['difficulty'],
        question: parsedJson['question'],
        correctAnswer: parsedJson['correct_answer'],
        incorrectAnswers: incorrectAnswersList,
        answers: List<String>.from(incorrectAnswersList)
          ..add(parsedJson['correct_answer'])
          ..shuffle());
  }
}

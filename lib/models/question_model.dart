class Question {
  String category;
  String type;
  String difficulty;
  String question;
  // ignore: non_constant_identifier_names
  String correct_answer;
  // ignore: non_constant_identifier_names
  List<String> incorrect_answers;

  Question({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    // ignore: non_constant_identifier_names
    this.correct_answer,
    // ignore: non_constant_identifier_names
    this.incorrect_answers,
  });

  factory Question.fromJson(Map<String, dynamic> parsedJson) {
    var incorrectAnswersFromJson = parsedJson['incorrect_answers'];
    List<String> incorrectAnswersList = incorrectAnswersFromJson.cast<String>();
    return Question(
        category: parsedJson['category'],
        type: parsedJson['type'],
        difficulty: parsedJson['difficulty'],
        question: parsedJson['question'],
        correct_answer: parsedJson['correct_answer'],
        incorrect_answers: incorrectAnswersList);
  }
}

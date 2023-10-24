class QuizQuestion {
  const QuizQuestion(this.question, this.answer);
  final String question;
  final List<String> answer;
  List<String> shuffleList() {
    final List<String> shuffledList = List.of(answer);
    shuffledList.shuffle();
    return shuffledList;
  }
}

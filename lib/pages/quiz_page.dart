import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/quiz.dart';
import '../ui/answer_button.dart';
import '../ui/correct_wrong_overlay.dart';
import '../ui/question_text.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;

  Quiz quiz = new Quiz([
    new Question('Lightning never strikes in the same place twice', false),
    new Question(
        'If you cry in space the tears just stick to your face', true),
    new Question(
        'If you cut an earthworm in half, both halves can regrow their body',
        false),
    new Question(
        'Humans can distinguish between over a trillion different smells',
        true),
  ]);

  String questionText;
  int questionNumber;
  bool isCorrect;
  bool displayOverlay = false;

  @override
  void initState() {
    super.initState();

    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);

    this.setState(() {
      displayOverlay = true;
    });
  }

  void hideOverlay() {
    if (quiz.length == questionNumber) {
      Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
          builder: (BuildContext context) {
            return new ScorePage(quiz.score, quiz.length);
          },
        ),
        (Route route) => route == null,
      );

      return;
    }

    currentQuestion = quiz.nextQuestion;

    this.setState(() {
      displayOverlay = false;
      questionText = currentQuestion.question;
      questionNumber = quiz.questionNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText, questionNumber),
            new AnswerButton(false, () => handleAnswer(false)),
          ],
        ),
        displayOverlay
            ? new CorrectWrongOverlay(isCorrect, () => hideOverlay())
            : new Container(),
      ],
    );
  }
}

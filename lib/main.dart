import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizzler/questionsBank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Flexible> scoreKeeper = [];
  String displayText;
  bool disableButtons = false;
  int correctAnswers = 0;
  double score = 0;
  final int totalOfQuestions = 15;
  final int winningScore = 80; // minimum percentage to pass the test
  int questionsAsked = 1;
  QuestionsBank questionsBank = QuestionsBank();

  _QuizPageState() {
    questionsBank.nextQuestion();
    displayText = questionsBank.getQuestionText();
  }

  void checkAnswer(bool selection) {
    setState(() {
      if (selection == questionsBank.getQuestionAnswer()) {
        correctAnswers++;
        scoreKeeper.add(
          Flexible(
            child: Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
        );
      } else {
        scoreKeeper.add(
          Flexible(
            child: Icon(
              Icons.close,
              color: Colors.red,
            ),
          ),
        );
      }
    });

    score = (correctAnswers / (totalOfQuestions)) * 100;
    questionsAsked++;
    questionsBank.nextQuestion();

    if (questionsAsked <= totalOfQuestions) {
      displayText = questionsBank.getQuestionText();
    } else {
      disableButtons = true;

      if (score < winningScore) {
        displayText =
            'Sorry you didn\'t pass the test. You need at least 80% correct answers.';
      } else {
        displayText = 'Awesome, you have passed the test.';
      }

      _onAlertButtonsPressed(context);
    }
  }

  void reset() {
    setState(() {
      scoreKeeper = [];
      disableButtons = false;
      correctAnswers = 0;
      score = 0;
      questionsAsked = 1;

      questionsBank.nextQuestion();
      displayText = questionsBank.getQuestionText();
    });
  }

  String getQuestionCounter() =>
      'Question $questionsAsked' + ' of ' + totalOfQuestions.toString();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Tooltip(
                        message: 'Restart',
                        child: FlatButton(
                          child: Icon(
                            Icons.refresh,
                            color: Colors.green,
                          ),
                          onPressed: () => reset(),
                        ),
                      ),
                      Tooltip(
                        message: 'Close',
                        child: FlatButton(
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          onPressed: () => SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop'),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CircularPercentIndicator(
                    radius: 90.0,
                    lineWidth: 10.0,
                    animation: true,
                    percent: score / 100,
                    center: Text(
                      score.round().toString() + '%',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                    footer: Text(
                      "Live Score",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor:
                        score < winningScore ? Colors.red : Colors.green,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        disableButtons ? ' ' : getQuestionCounter(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Center(
                        child: Text(
                          displayText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.green,
              disabledColor: Colors.grey,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: disableButtons ? null : () => checkAnswer(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              disabledColor: Colors.grey,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: disableButtons ? null : () => checkAnswer(false),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ],
    );
  }

  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      type: score >= winningScore ? AlertType.success : AlertType.error,
      title: "You Have Finished",
      desc: displayText,
      closeFunction: () {},
      buttons: [
        DialogButton(
          child: Text(
            "TRY AGAIN",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            reset();
            Navigator.pop(context);
          },
          //onPressed: reset(),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "CLOSE",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }
}

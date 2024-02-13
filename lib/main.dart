import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  List<String> _questions = [
    "What is a circular object that rotates around an axle and is often used in transportation, machinery, and various other applications to facilitate movement or the transmission of power?",
    "Fill in the Blank: ____ belong with me.",
    "What is this animal? 'Show the picture of Bee'",
    "What comes after April?",
    "Drew is 54 years old. Valentine is twice as old as Jesus. Who's older?"
  ];
  List<List<String>> _choices = [
    ["Wheel", "Cogs", "Silo", "Screw"],
    ["She", "He", "You", "I"],
    ["Lion", "Bee", "Tiger", "Giraffe"],
    ["June", "May", "March", "Fool's Day"],
    ["Jesus", "Drew", "Ako", "Valentine"]
  ];
  List<String> _correctAnswers = ["Wheel", "You", "Bee", "May", "Valentine"];
  String _userAnswer = "";
  int _countdown = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (_countdown < 1) {
          t.cancel();
          checkAnswer(context);
        } else {
          _countdown--;
        }
      });
    });
  }

  void nextQuestion() {
    if (_questionIndex < _questions.length - 1) {
      setState(() {
        _questionIndex++;
        _countdown = 10;
        _timer?.cancel();
        startTimer();
      });
    } else {
      _timer?.cancel();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CorrectAnswersScreen(correctAnswers: _correctAnswers)),
      );
    }
  }

  void checkAnswer(BuildContext context) {
    if (_userAnswer == _correctAnswers[_questionIndex]) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Correct!'),
          duration: Duration(seconds: 2),
        ),
      );
      nextQuestion();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Incorrect. The correct answer is ${_correctAnswers[_questionIndex]}'),
          duration: Duration(seconds: 2),
        ),
      );
      _countdown = 10;
      _timer?.cancel();
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _questions[_questionIndex],
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            Column(
              children: List.generate(
                _choices[_questionIndex].length,
                (index) {
                  return RadioListTile<String>(
                    title: Text(_choices[_questionIndex][index]),
                    value: _choices[_questionIndex][index],
                    groupValue: _userAnswer,
                    onChanged: (value) {
                      setState(() {
                        _userAnswer = value!;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Time left: $_countdown seconds',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () => checkAnswer(context),
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class CorrectAnswersScreen extends StatelessWidget {
  final List<String> correctAnswers;

  CorrectAnswersScreen({required this.correctAnswers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Correct Answers'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Correct Answers:'),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                correctAnswers.length,
                (index) {
                  return Text(
                    correctAnswers[index],
                    style: TextStyle(fontSize: 16.0),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YesOrNoScreen()),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class YesOrNoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wiee'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Will You Be My Valentine's?",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YEHEYScreen()),
                );
              },
              child: Text('Yes'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YEHEYScreen()),
                );
              },
              child: Text('YES!!!'),
            ),
          ],
        ),
      ),
    );
  }
}

class YEHEYScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YEHEY'),
      ),
      body: Center(
        child: Text(
          'YEHEY I LOVE YOU BABY\nMWAMWAMWA',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}

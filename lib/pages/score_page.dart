import 'package:flutter/material.dart';

import 'landing_page.dart';

class ScorePage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ScorePage(this.score, this.totalQuestions);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blueAccent,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Score',
            style: new TextStyle(
              color: Colors.white,
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          new Text(
            '$score / $totalQuestions',
            style: new TextStyle(
              color: Colors.white,
              fontSize: 28.0,
            ),
          ),
          new IconButton(
            icon: new Icon(Icons.forward),
            color: Colors.white,
            iconSize: 50.0,
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(
                  builder: (BuildContext context) => new LandingPage(),
                ),
                (Route route) => route == null),
          ),
        ],
      ),
    );
  }
}

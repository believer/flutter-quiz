import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget {
  final String _question;
  final int _questionNumber;

  QuestionText(this._question, this._questionNumber);

  @override
  State<StatefulWidget> createState() => new QuestionTextState();
}

class QuestionTextState extends State<QuestionText>
    with SingleTickerProviderStateMixin {
  Animation<double> _fontAnimation;
  AnimationController _fontAnimationController;

  @override
  void initState() {
    super.initState();

    _fontAnimationController = new AnimationController(
      duration: new Duration(milliseconds: 500),
      vsync: this,
    );

    _fontAnimation = new CurvedAnimation(
      parent: _fontAnimationController,
      curve: Curves.easeInOut,
    );

    _fontAnimationController.addListener(() => this.setState(() {}));
    _fontAnimationController.forward();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget._question != widget._question) {
      _fontAnimationController.reset();
      _fontAnimationController.forward();
    }
  }

  @override
  void dispose() {
    _fontAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.white,
      child: new Padding(
        padding: new EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 10.0,
        ),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: new Text(
                  'Statement ' + widget._questionNumber.toString(),
                  style: new TextStyle(
                    fontSize: _fontAnimation.value * 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              new Text(
                widget._question,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontSize: _fontAnimation.value * 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

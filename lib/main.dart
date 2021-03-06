import 'package:flutter/material.dart';
import 'package:tictactoe/Game.dart';
import 'package:tictactoe/RowView.dart';
import 'package:dart_range/dart_range.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Tic Tac Toe',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new GameView(title: 'Tic Tac Toe'),
    );
  }
}

class GameView extends StatefulWidget {
  GameView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GameView createState() {
    var player1 = new Player("player one", "X");
    var player2 = new Player("player two", "O");
    var game = new Game(player1, player2, 4);
    return new _GameView(game);
  }
}

class _GameView extends State<GameView> {
  Game game;

  _GameView(this.game);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: createListView(),
      ),
    );
  }

  Widget createListView() {
    var restartButton = new RaisedButton(
      onPressed: () => restartGame(),
      child: new Text("Restart"),
    );
    List<Widget> rows = [];
    inclusiveRange(0, game.numberOfRowColumns).forEach((index) {
      if (index != game.numberOfRowColumns) {
        rows.add(new RowView(game, index, callback));
      } else {
        rows.add(restartButton);
      }
    });
    return new ListView(children: rows);
  }

  String callback(row, column) {
    String winCheck;
    setState(() {
      var success = game.setPlayer(row, column);
      if (success) {
        winCheck = game.winCheck();
      }
    });
    return winCheck;
  }

  restartGame() {
    setState(() {
      this.game.restart();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tictactoe/Game.dart';

class CellView extends StatelessWidget {
  final Game game;
  final column;
  final row;
  final callback;

  CellView(this.game, this.row, this.column, this.callback);

  @override
  Widget build(BuildContext context) {
    var playerString =
        game.playerString(atRow: this.row, atColumn: this.column);
    var button = new Text(playerString);
    return new RaisedButton(
      onPressed: () => buttonPressed(row, column, context),
      child: button,
    );
  }

  buttonPressed(row, column, BuildContext context) {
    var message = this.callback(row, column);
    if (message != null && message != "") {
      Scaffold
          .of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }
}

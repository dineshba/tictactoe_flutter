import 'package:flutter/material.dart';
import 'package:tictactoe/CellView.dart';

class RowView extends StatelessWidget {
  final row;
  final callback;
  final players;

  RowView(this.players, this.row, this.callback);

  @override
  Widget build(BuildContext context) {
    var row = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new CellView(this.players[0], this.row, 0, this.callback),
        new CellView(this.players[1], this.row, 1, this.callback),
        new CellView(this.players[2], this.row, 2, this.callback)
      ],
    );
    var container = new Container(
      child: row,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
    );
    return container;
  }
}

import 'package:flutter/material.dart';
import 'package:dart_range/dart_range.dart';
import 'package:tictactoe/CellView.dart';
import 'package:tictactoe/Game.dart';

class RowView extends StatelessWidget {
  final row;
  final callback;
  final Game game;

  RowView(this.game, this.row, this.callback);

  @override
  Widget build(BuildContext context) {
    var cells = range(0, game.numberOfRowColumns).map((index) {
      return new CellView(this.game, this.row, index, this.callback);
    }).toList();
    var row = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: cells,
    );
    var container = new Container(
      child: row,
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
    );
    return container;
  }
}

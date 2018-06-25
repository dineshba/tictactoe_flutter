import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CellView extends StatelessWidget {
  final player;
  final column;
  final row;
  final callback;

  CellView(this.player, this.row, this.column, this.callback);

  @override
  Widget build(BuildContext context) {
    var symbol = "";
    if (player != null) {
      symbol = player.symbol;
    }
    var button = new Text(symbol);
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

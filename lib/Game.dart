import 'package:dart_range/dart_range.dart';

class Game {
  Player playerOne;
  Player playerTwo;
  bool isPlayerOneTurn = true;
  bool gameOver = false;

  List<Player> values;

  int numberOfRowColumns;

  Game(this.playerOne, this.playerTwo, this.numberOfRowColumns) {
    this.values = resetValues();
  }

  List<Player> resetValues() {
    Player mapper(int) {
      return null;
    }

    return range(0, numberOfRowColumns * numberOfRowColumns)
        .map(mapper)
        .toList();
  }

  togglePlayerOneTurn() {
    this.isPlayerOneTurn = !this.isPlayerOneTurn;
  }

  bool setPlayer(int row, int column) {
    var index = (row * numberOfRowColumns) + column;
    if (!(hasValue(index) || gameOver)) {
      if (this.isPlayerOneTurn) {
        this.values[index] = playerOne;
      } else {
        this.values[index] = playerTwo;
      }
      togglePlayerOneTurn();
      return true;
    }
    return false;
  }

  List<Player> getForRow(int row) {
    var start = row * numberOfRowColumns;
    var range = this.values.getRange(start, start + numberOfRowColumns);
    return range.toList();
  }

  List<Player> getForColumn(int column) {
    return range(0, numberOfRowColumns).map((index) {
      return this.values[column + (index * numberOfRowColumns)];
    }).toList();
  }

  bool hasValue(int i) => this.values[i] != null;

  String winCheck() {
    var message = "";
    if (!isPlayerOneTurn) {
      var win = winCheckFor(playerOne);
      if (win) {
        gameOver = true;
        message = "Player One Won the Game";
      }
    } else {
      var win = winCheckFor(playerTwo);
      if (win) {
        gameOver = true;
        message = "Player Two Won the Game";
      }
    }
    return message;
  }

  bool winCheckFor(player) =>
      horizontalCheck(player) || verticalCheck(player) || diagonalCheck(player);

  bool horizontalCheck(Player player) {
    bool win = false;
    range(0, numberOfRowColumns).forEach((row) {
      if (!win) {
        win = this.getForRow(row).where((p) => player == p).toList().length ==
            numberOfRowColumns;
      }
    });
    return win;
  }

  void restart() {
    this.values = resetValues();
    this.gameOver = false;
    this.isPlayerOneTurn = true;
  }

  bool verticalCheck(Player player) {
    bool win = false;
    range(0, numberOfRowColumns).forEach((column) {
      if (!win) {
        win = this
                .getForColumn(column)
                .where((p) => player == p)
                .toList()
                .length ==
            numberOfRowColumns;
      }
    });
    return win;
  }

  bool diagonalCheck(Player player) {
    var diagonal = range(0, numberOfRowColumns)
            .map((index) => index + (index * numberOfRowColumns))
            .map((index) => this.values[index])
            .where((p) => player == p)
            .length ==
        numberOfRowColumns;
    var crossDiagonal = range(0, numberOfRowColumns)
            .map((index) => ((index + 1) * numberOfRowColumns) - (index + 1))
            .map((index) => this.values[index])
            .where((p) => player == p)
            .length ==
        numberOfRowColumns;
    return diagonal || crossDiagonal;
  }

  String playerString({int atRow, int atColumn}) {
    var player = this.values[atRow * numberOfRowColumns + atColumn];
    if (player == null) {
      return "";
    } else {
      return player.symbol;
    }
  }
}

class Player {
  final name;
  final symbol;

  Player(this.name, this.symbol);
}

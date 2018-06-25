class Game {
  Player playerOne;
  Player playerTwo;
  bool isPlayerOneTurn = true;
  bool gameOver = false;

  List<Player> values;

  Game(this.playerOne, this.playerTwo) {
    this.values = [
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ];
  }

  setPlayer(int player, int position) {}

  togglePlayerOneTurn() {
    this.isPlayerOneTurn = !this.isPlayerOneTurn;
  }

  bool set(int row, int column) {
    var i = (row * 3) + column;
    if (!(hasValue(i) || gameOver)) {
      if (this.isPlayerOneTurn) {
        this.values[i] = playerOne;
      } else {
        this.values[i] = playerTwo;
      }
      togglePlayerOneTurn();
      return true;
    }
    return false;
  }

  List<Player> getForRow(int row) {
    var start = row * 3;
    var range = this.values.getRange(start, start + 3);
    return range.toList();
  }

  List<Player> getForColumn(int column) {
    return [
      this.values[column],
      this.values[column + 3],
      this.values[column + 6]
    ];
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
    [0, 1, 2].forEach((row) {
      if (!win) {
        win =
            this.getForRow(row).where((p) => player == p).toList().length == 3;
      }
    });
    return win;
  }

  void restart() {
    this.values = [
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    ];
    this.gameOver = false;
    this.isPlayerOneTurn = true;
  }

  bool verticalCheck(Player player) {
    bool win = false;
    [0, 1, 2].forEach((column) {
      if (!win) {
        win = this
                .getForColumn(column)
                .where((p) => player == p)
                .toList()
                .length ==
            3;
      }
    });
    return win;
  }

  bool diagonalCheck(Player player) {
    var diagonal = [0, 4, 8]
            .map((index) => this.values[index])
            .toList()
            .where((p) => player == p)
            .toList()
            .length ==
        3;
    var crossDiagonal = [2, 4, 6]
            .map((index) => this.values[index])
            .toList()
            .where((p) => player == p)
            .toList()
            .length ==
        3;
    return diagonal || crossDiagonal;
  }
}

class Player {
  final name;
  final symbol;

  Player(this.name, this.symbol);
}

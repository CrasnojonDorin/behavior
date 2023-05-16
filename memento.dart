class Game {
  int _score;
  int _level;

  Game(this._score, this._level);

  int get score => _score;
  int get level => _level;

  void setScore(int score) {
    _score = score;
  }

  void setLevel(int level) {
    _level = level;
  }

  Memento save() {
    return Memento(_score, _level);
  }

  void restore(Memento memento) {
    _score = memento.score;
    _level = memento.level;
  }

  void printState() {
    print("Current game state: score=$_score, level=$_level");
  }
}

class Memento {
  final int score;
  final int level;

  Memento(this.score, this.level);
}

class Caretaker {
  final List<Memento> _mementos = [];

  void add(Memento memento) {
    _mementos.add(memento);
  }

  Memento get(int index) {
    return _mementos[index];
  }
}

void main() {
  var game = Game(0, 1);
  var caretaker = Caretaker();

  caretaker.add(game.save());

  game.setScore(100);
  game.setLevel(2);

  caretaker.add(game.save());

  game.setScore(200);
  game.setLevel(3);

  game.restore(caretaker.get(0));
  game.printState();

  game.restore(caretaker.get(1));
  game.printState();
}

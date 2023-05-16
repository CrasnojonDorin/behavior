class Song {
  final String title;
  final String artist;
  final int duration;

  Song(this.title, this.artist, this.duration);

  @override
  String toString() => '$title by $artist';
}

class Playlist {
  final List<Song> _songs = [];

  void addSong(Song song) {
    _songs.add(song);
  }

  void removeSong(Song song) {
    _songs.remove(song);
  }
}

abstract class Command {
  void execute(Playlist playlist);
  void undo(Playlist playlist);
}

class AddSongCommand implements Command {
  final Song _song;

  AddSongCommand(this._song);

  @override
  void execute(Playlist playlist) {
    playlist.addSong(_song);
  }

  @override
  void undo(Playlist playlist) {
    playlist.removeSong(_song);
  }
}

class RemoveSongCommand implements Command {
  final Song _song;

  RemoveSongCommand(this._song);

  @override
  void execute(Playlist playlist) {
    playlist.removeSong(_song);
  }

  @override
  void undo(Playlist playlist) {
    playlist.addSong(_song);
  }
}

class Invoker {
  late Command _command;

  void setCommand(Command command) {
    _command = command;
  }

  void executeCommand(Playlist playlist) {
    _command.execute(playlist);
  }

  void undoCommand(Playlist playlist) {
    _command.undo(playlist);
  }
}

void main() {
  var playlist = Playlist();

  var song1 = Song('Song 1', 'Artist 1', 180);
  var song2 = Song('Song 2', 'Artist 2', 210);
  var song3 = Song('Song 3', 'Artist 3', 240);

  var addCommand1 = AddSongCommand(song1);
  var addCommand2 = AddSongCommand(song2);
  var addCommand3 = AddSongCommand(song3);

  var removeCommand1 = RemoveSongCommand(song1);
  var removeCommand2 = RemoveSongCommand(song2);

  var invoker = Invoker();

  invoker.setCommand(addCommand1);
  invoker.executeCommand(playlist);

  invoker.setCommand(addCommand2);
  invoker.executeCommand(playlist);

  invoker.setCommand(addCommand3);
  invoker.executeCommand(playlist);

  print('Playlist after adding 3 songs:');
  playlist._songs.forEach((song) => print(song));

  invoker.setCommand(removeCommand1);
  invoker.executeCommand(playlist);

  invoker.setCommand(removeCommand2);
  invoker.executeCommand(playlist);

  print('Playlist after removing 2 songs:');
  playlist._songs.forEach((song) => print(song));

  invoker.setCommand(removeCommand2);
  invoker.undoCommand(playlist);

  print('Playlist after undoing the second song:');
  playlist._songs.forEach((song) => print(song));
}

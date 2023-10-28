import 'package:buchverwaltung/datenbank.dart';
import 'package:logging/logging.dart';

enum Genre { fiction, history, nonfiction }

// Model eines Buches
class Buch {
  String name;
  List<String> authoren;
  String? isbn;
  int? seitenAnzahl;
  int? version;
  DateTime? erscheinungsdatum;
  Genre genre;

  Buch.minimal(this.name, this.authoren, this.genre);

  Buch.voll(this.name, this.authoren, this.isbn, this.seitenAnzahl,
      this.version, this.erscheinungsdatum, this.genre);

  @override
  String toString() {
    if (version == null && isbn == null) {
      return 'Buch [$name $authoren $genre]';
    }
    return 'Buch [$name $authoren $genre $isbn $seitenAnzahl $version ${erscheinungsdatum?.toIso8601String()}]';
  }
}

// Data access object für Bücher
class Buecherei {

  late Datenbank _db;
  final _log = Logger('Buecherei');

  Buecherei.injected(this._db);

  Buecherei.dummy() {
    _db = Datenbank.dummy();
  }

  hinzufuege(Buch buch) async {
    await _db.create(buch);
  }

  loeschen(Buch buch) async {
    await _db.delete(buch);
  }

  // suchen ohne parameter gibt ganzen db inhalt zurück
  Future<List<Buch>> suchen({String? name, List<String>? author, Genre? genre, String? isbn}) async {
    if (name == null && author == null && genre == null && isbn == null) {
      return await _db.listAll();
    }
    else {
      return await _db.query(name: name, author: author, genre: genre, isbn: isbn);
    }
  }
}

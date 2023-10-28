import 'package:buchverwaltung/buecherei.dart';
import 'package:logging/logging.dart';

class Datenbank {

  final _log = Logger('Datenbank');

  List<Buch> _books = [];

  Datenbank.dummy() {
    /** Add dummy books for local testing */
    _books.add(Buch.minimal(
        "Grimms Maerchen", ["A. Grimm", "B. Grimm"], Genre.fiction));
    _books.add(Buch.voll("A Hacker's Mind", ["Bruce Schneier"],
        "978-0-393-86666-7", 284, 1, DateTime(2023, 10, 17), Genre.nonfiction));
  }

  create(Buch buch) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _books.add(buch)
    );
  }

  /*update(Buch buch) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => {
        for (Buch b in _books) {
          if (b.name == buch.name) {
            b = buch;
            this.create(buch);
          }
        }
      }
    );
  }*/

  delete(Buch buch) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _books.remove(buch)
    );
  }

  // eigentliches suchquery zur einfacheren handhabung aus dem future delayed ausgelagert
  List<Buch> _query({String? name, List<String>? author, Genre? genre, String? isbn}) {
    List<Buch> matching = [];

    _log.fine('Testing $name, $author, $genre, $isbn');

    for (Buch b in _books) {
      _log.fine('Versus $b');
      if (
        (name == null || name == b.name) &&
        (genre == null || genre == b.genre) &&
        (isbn == null || isbn == b.isbn)
      ) {
        if (author != null) {
          bool containsAll = true;
          for (String aut in author) {
            if (!b.authoren.contains(aut)) {
              containsAll = false;
              break;
            }
          }
          if (!containsAll) {
            continue;
          }
        }

        matching.add(b);
      }
    }

    return matching;
  }

  Future<List<Buch>> query({String? name, List<String>? author, Genre? genre, String? isbn}) async {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _query(name: name, author: author, genre: genre, isbn: isbn));
  }

  Future<List<Buch>> listAll() async {
    return Future.delayed(
      const Duration(milliseconds: 100),
      () => _books
    );
  }
}
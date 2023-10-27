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
}

// Data access object für Bücher
class Buecherei {
  // Momentan ohne DB
  List<Buch> buecher = [];

  Buecherei.dummy() {
    /** Add dummy books for local testing */
    buecher.add(Buch.minimal(
        "Grimms Maerchen", ["A. Grimm", "B. Grimm"], Genre.fiction));
    buecher.add(Buch.voll("A Hacker's Mind", ["Bruce Schneier"],
        "978-0-393-86666-7", 284, 1, DateTime(2023, 10, 17), Genre.nonfiction));
  }

  hinzufuege(Buch buch) {}

  Buch lesen() {
    return Buch.minimal("n", [], Genre.fiction);
  }

  List<Buch> suchen() {
    return [];
  }
}

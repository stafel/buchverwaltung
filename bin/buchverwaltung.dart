import 'package:buchverwaltung/buecherei.dart';
import 'package:logging/logging.dart';



void main(List<String> arguments) async {

  Logger.root.level = Level.INFO;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  final log = Logger('main');

  var dummy = Buecherei.dummy();

  log.info('Initial: ${await dummy.suchen()}');

  log.info('Buch Astrotopia hinzufügen');
  Future<void> future = dummy.hinzufuege(Buch.minimal("Astrotopia", ["Mary-Jane Rubenstein"], Genre.nonfiction));

  log.info('Listenabfrage ohne await: ${await dummy.suchen()}');

  await Future.wait([future]);
  log.info('Listenabfrage mit neuem Buch: ${await dummy.suchen()}');

  log.info('Suche Buch mit Author B. Schneier: ${await dummy.suchen(author: ["Bruce Schneier"])}');

  log.info('Nonfiction Bücher löschen');
  List<Future<void>> futures = [];
  for (Buch b in await dummy.suchen(genre: Genre.nonfiction)) {
    futures.add(dummy.loeschen(b));
  }

  await Future.wait(futures);

  log.info('Listenabfrage: ${await dummy.suchen()}');
}

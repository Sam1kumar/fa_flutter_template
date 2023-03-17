import 'package:fa_flutter_template/data/local/app_db.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class SembastAppDb extends AppDb {
  SembastAppDb();

  Database? db;
  @override
  Future<void> initialise() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = join(dir.path, 'fa_flutter_mt_database.db');
      db = await databaseFactoryIo.openDatabase(dbPath);
    } catch (e, s) {
      print(e);
      throw Exception("Error in initialising sembast Db");
    }
  }

  @override
  Future<void> clear() async {
    print("Clearing sembast app db...");
    // [ChangeThis] Here call clear function of all StoreRef in the app.
    print('Clearing sembast app successful');
  }
}

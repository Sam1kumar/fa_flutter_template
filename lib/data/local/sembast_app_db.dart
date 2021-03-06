import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:fa_flutter_template/data/local/app_db.dart';
import 'package:fa_flutter_template/utils/log_utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';
class SembastAppDb extends AppDb {
  SembastAppDb();

  Database? db;
  @override
  Future<void> initialise() async {
    try {
      if (isWeb) {
        final factory = databaseFactoryWeb;
        db = await factory.openDatabase('fa_flutter_mt_database');
      } else {
        final dir = await getApplicationDocumentsDirectory();
        await dir.create(recursive: true);
        final dbPath = join(dir.path, 'fa_flutter_mt_database.db');
        db = await databaseFactoryIo.openDatabase(dbPath);
      }
    } catch (e, s) {
      logger.e(e, s);
      throw Exception("Error in initialising sembast Db");
    }
  }

  @override
  Future<void> clear() async {
    logger.i("Clearing sembast app db...");
    // [ChangeThis] Here call clear function of all StoreRef in the app.
    logger.i('Clearing sembast app successful');
  }

}

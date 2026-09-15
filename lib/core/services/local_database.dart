import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';

part 'local_database.g.dart';

/// The single Drift database instance for the app. Table definitions
/// live in each feature's data/ layer (dictionary, history, favorites)
/// via `@DriftDatabase(tables: [...])` composition — this file only
/// owns connection lifecycle, kept minimal for Phase 1. Phase 3 wires
/// in the actual table classes.
@DriftDatabase(tables: [])
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase._(super.e);

  static LocalDatabase? _instance;

  static Future<LocalDatabase> open() async {
    if (_instance != null) return _instance!;
    _instance = LocalDatabase._(_openConnection());
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = p.join(dbFolder.path, 'ankh_lens.sqlite');
      // Ensures the correct native sqlite3 lib is loaded on Android/iOS.
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      return NativeDatabase.createInBackground(
        File(file),
        setup: (rawDb) {
          rawDb.execute('PRAGMA foreign_keys = ON;');
        },
      );
    });
  }
}

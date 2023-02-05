import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../model/user_model.dart';


class DbHelper {
  static Database? _db;

  static const String dbName = 'test.db';
  static const int version = 1;
  // static const String _userId = 'user_id';
  static const String tableUser = 'user';
  static const String userName = 'user_name';
  static const String email = 'email';
  static const String _password = 'password';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableUser ("
        // " $_userId TEXT, "
        " $userName TEXT, "
        " $email TEXT,"
        " $_password TEXT, "
        " PRIMARY KEY ($userName)"
        ")");
  }



  Future<int> saveData(UserModel userModel) async {
    var dbClient = await db;
    var res = await dbClient!.insert(tableUser, userModel.toJson());
    return res;
  }

  Future<UserModel?> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient!.rawQuery("SELECT * FROM $tableUser WHERE "
        "$userName = '$userId' And "
        "$_password = '$password'");
    if(res.isNotEmpty){
      return UserModel.fromJson(res.first);
    }
    return null;
  }
}

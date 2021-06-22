import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/model/user.dart';

class UserDatabase {
  static final UserDatabase instance =
      UserDatabase._init(); // Calling the constructor
  static Database? _db; // Declare db variable

  UserDatabase._init(); // Private constructor

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb('test.db');
    return _db!;
  }

  static Future<Database> _initDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    await deleteDatabase(path);

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE users (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT NOT NULL, password NOT NULL, token NOT NULL, createdAt TEXT NOT NULL)');
    });
  }

  static Future<User> register(User user) async {
    Database db = await instance.database;

    try {
      final int id = await db.insert('users', user.toJson());
      return user.copy(id: id);
    } catch (e) {
      throw "Registration failed : $e";
    }
  }

  static Future<dynamic> login(User user) async {
    Database db = await instance.database;
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      // print("USER : $user");
      List<Map> resp = await db.rawQuery(
          "SELECT * FROM users WHERE email=? AND PASSWORD=?",
          [user.email, user.password]);

      if (resp.length > 0) {
        User user = User.fromJson(resp.first);
        pref.setString("token", resp.first['token']);
        return Future.value(user);
      } else {
        throw "Invalid email or password";
      }
    } catch (e) {
      throw "Invalid email or password";
    }
  }
}

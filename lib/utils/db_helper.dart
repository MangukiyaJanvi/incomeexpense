import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database? database;

  Future<Database?> checkDB() async {
    if (database != null) {
      return database;
    } else {
      return await initDB();
    }
  }

  Future<Future<Database>> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "rnw.db");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE incomeexpence (id INTEGER PRIMARY KEY AUTOINCREMENT,category TEXT,amount TEXT,notes TEXT,date TEXT,time TEXT,paytypes TEXT,status INTEGER)";
        db.execute(query);
      },
    );
  }

  void insertData(
      {required category,
      required notes,
      required status,
      required amount,
      required paytypes,
      required date,
      required time}) async {
    database = await checkDB();
    database!.insert("incomeexpence", {
      "category": category,
      "amount": amount,
      "notes": notes,
      "date": date,
      "time": time,
      "status": status,
      "paytypes": paytypes
    });
  }

  Future<List<Map>> readData() async {
    database = await checkDB();
    String query = "SELECT * FROM incomeexpence";
    List<Map> list = await database!.rawQuery(query);
    return list;
  }

  Future<List<Map>> filterRead({required statusCode}) async {
    database = await checkDB();
    var query = "SELECT * FROM incomeexpence WHERE status=$statusCode";
    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }

  Future<List<Map>> filterCate({required cate}) async {
    database = await checkDB();
    var query = "SELECT * FROM incomeexpence WHERE category=$cate";
    List<Map> l1 = await database!.rawQuery(query);
    return l1;
  }

  Future<void> deleteData({required id}) async {
    database = await checkDB();
    database!.delete("incomeexpence", where: "id=?", whereArgs: [id]);
  }

  Future<void> updateDate(
      {required id,
      required category,
      required notes,
      required status,
      required amount,
      required paytypes,
      required date,
      required time}) async {
    database = await checkDB();
    database!.update(
        "incomeexpence",
        {
          "category": category,
          "amount": amount,
          "notes": notes,
          "date": date,
          "time": time,
          "status": status,
          "paytypes": paytypes
        },
        whereArgs: [id],
        where: "id=?");
  }

  Future<List<Map>> allFilterRead(
      {fromDate, toDate, payTypes, status, category}) async {
    database = await checkDB();
    String query = "";
    if (fromDate != null &&
        toDate != null &&
        payTypes != null &&
        status != null &&
        category != null) {
      query =
          "SELECT * FROM incomeexpence WHERE date>='$fromDate' AND date<='$toDate' AND paytypes='$payTypes' AND status='$status'";
    } else if (fromDate != null && toDate != null) {
      query =
          "SELECT * FROM incomeexpence WHERE date>='$fromDate' AND date<='$toDate'";
    } else if (payTypes != null) {
      query = "SELECT * FROM incomeexpence WHERE paytypes='$payTypes'";
    } else if (fromDate != null && toDate != null && payTypes != null) {
      query =
          "SELECT * FROM incomeexpence WHERE date>='$fromDate' AND date<='$toDate' AND paytypes='$payTypes'";
    }
    print(query);
    List<Map> l1 = await database!.rawQuery(query);
    print(l1);
    return l1;
  }


  Future<List<Map>> totalIncome() async {
    database = await checkDB();
    String sql = 'SELECT SUM(amount) FROM incomeexpence WHERE status=1';
    List<Map> list = await database!.rawQuery(sql);
    print(list);
    return list;
  }

  Future<List<Map>> totalExpanse() async {
    database = await checkDB();
    String sql = 'SELECT SUM(amount) FROM incomeexpence WHERE status=0';
    List<Map> list = await database!.rawQuery(sql);
    print(list);
    return list;
  }
}

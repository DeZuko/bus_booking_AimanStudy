import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbInit {
  static Future<void> createTable(Database db) async {
    await db.execute("""
    CREATE TABLE user(
      user_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      f_name TEXT NOT NULL,
      l_name TEXT NOT NULL,
      username TEXT NOT NULL,
      password TEXT NOT NULL,
      mobilehp TEXT NOT NULL
    )
    """);

    //VARCHAR(50)

    await db.execute("""
    CREATE TABLE station_type(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      station TEXT,
      code TEXT,
      imageURL TEXT
    )
    """);

    await db.execute("""
    INSERT INTO station_type(station,code,imageURL)
    VALUES
      ('Kuala Lumpur','KUL','assets/images/KL.png'),
      ('Johor Bahru','JHB','assets/images/JB.png'),
      ('Kota Bahru','KBR','assets/images/KB.png'),
      ('Alor Setar','ASR','assets/images/AlorSetar.png'),
      ('Melaka','MK','assets/images/Melaka.png')

    """);

    await db.execute(""" CREATE TABLE busticket(
      book_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      depart_date DATE NOT NULL,
      time TIME NOT NULL,
      depart_station VARCHAR(20) NOT NULL,
      dest_station VARCHAR(20) NOT NULL,
      user_id INTEGER NOT NULL
    )""");
  }

  // Connect to database
  static Future<Database> connect() async {
    String path = join(await getDatabasesPath(), 'bus_booking.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await createTable(db);
      },
    );
  }

  // Delete database
  static Future<void> deleteDatabase(String path) async {
    databaseFactory.deleteDatabase(path);
  }
}

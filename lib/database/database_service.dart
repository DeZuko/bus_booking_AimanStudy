import 'package:mytest/models/bus_ticket.dart';
import 'package:mytest/models/station.dart';
import 'package:mytest/models/user.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseServices {
  Database db;
  DatabaseServices({
    required this.db,
  });

  // INSERT based on username (Registration)
  Future<dynamic> register(User user) async {
    // Check if username existed
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ?',
      whereArgs: [user.username],
    );

    if (result.isNotEmpty) {
      return null;
    } else {
      // If username not exist, create user
      db.insert(
        'user',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      return user;
    }
  }

  // RETRIEVE based on username and password (Login)
  Future<dynamic> login(String username, String password) async {
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'username = ? and password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Station>> getAllStation() async {
    List<Station> result = (await db.query('station_type'))
        .map((e) => Station.fromMap(e))
        .toList();

    return result;
  }

  /* BOOKING */
  // GET all booking
  Future<List<BusTicket>> getAllBooking() async {
    List<BusTicket> result =
        (await db.query('busticket')).map((e) => BusTicket.fromMap(e)).toList();

    return result;
  }

  // INSERT booking
  Future<int> createBooking(BusTicket busTicket) async {
    return await db.insert(
      'busticket',
      busTicket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // UPDATE booking
  Future<int> updateBooking(BusTicket busTicket) async {
    return await db.update(
      'busticket',
      busTicket.toMap(),
      where: "book_id=?",
      whereArgs: [busTicket.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // DELETE booking
  Future deleteBooking(int bookingId) async {
    await db.delete('busticket', where: "book_id=?", whereArgs: [bookingId]);
  }

  // GET user profile
  Future<User?> getUser(int id) async {
    final List<Map<String, dynamic>> result = await db.query(
      'user',
      where: 'user_id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }
}

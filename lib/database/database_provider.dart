import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

class DbProvider extends ChangeNotifier {
  Database db;
  DbProvider({
    required this.db,
  });
}

import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (kIsWeb) {
      // On Web, we should NEVER call this. using methods that check kIsWeb first.
      // But if something slips through, this throws.
      // Ideally we don't throw, but return a dummy or null, but the type is Database.
      throw UnsupportedError("SQLite not available on Web");
    }
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // This method should only be called on Mobile/Desktop
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'yb_news.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id TEXT PRIMARY KEY,
            email TEXT NOT NULL UNIQUE,
            password TEXT NOT NULL,
            name TEXT,
            isFirstLogin INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // --- Methods with Web Fallback ---

  Future<int> insertUser(Map<String, dynamic> user) async {
    if (kIsWeb) {
      return await _webInsertUser(user);
    }
    final db = await database;
    return await db.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    if (kIsWeb) {
      return await _webGetUser(email);
    }
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    }
    return null;
  }

  Future<void> updateUser(Map<String, dynamic> user) async {
    if (kIsWeb) {
      await _webUpdateUser(user);
      return;
    }
    final db = await database;
    await db.update('users', user, where: 'id = ?', whereArgs: [user['id']]);
  }

  Future<void> deleteUser(String id) async {
    if (kIsWeb) {
      return;
    }
    final db = await database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // --- Web Fallback Implementation (SharedPreferences) ---

  Future<List<Map<String, dynamic>>> _getWebUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final String? usersString = prefs.getString('web_db_users');
    if (usersString != null) {
      final List<dynamic> decoded = jsonDecode(usersString);
      return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return [];
  }

  Future<void> _saveWebUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('web_db_users', jsonEncode(users));
  }

  Future<int> _webInsertUser(Map<String, dynamic> user) async {
    final users = await _getWebUsers();
    // Remove existing if any (ConflictAlgorithm.replace behavior)
    users.removeWhere(
      (u) => u['id'] == user['id'] || u['email'] == user['email'],
    );
    users.add(user);
    await _saveWebUsers(users);
    return 1;
  }

  Future<Map<String, dynamic>?> _webGetUser(String email) async {
    final users = await _getWebUsers();
    try {
      return users.firstWhere((u) => u['email'] == email);
    } catch (e) {
      return null;
    }
  }

  Future<void> _webUpdateUser(Map<String, dynamic> user) async {
    final users = await _getWebUsers();
    final index = users.indexWhere((u) => u['id'] == user['id']);
    if (index != -1) {
      users[index] = user;
      await _saveWebUsers(users);
    }
  }
}

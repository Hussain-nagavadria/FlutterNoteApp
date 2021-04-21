import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:note_app/models/NoteModel.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; //singleton databasehelper
  static Database _database;

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance(); //named constructor to create instance of databaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); //this is executed onlyonce singleton object
    }
    return _databaseHelper;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
      return _database;
    }
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT,'
        '$colDescription TEXT , $colPriority INTEGER, $colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getNoteMaplist() async {
    Database db = await this.database;
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  Future<int> updateNote(NoteModel noteModel) async{
    Database db=await this.database;
    var result= await db.insert(noteTable,noteModel.toMap());
    return result;
  }
 Future<int> deleteNote(int id) async{
    var db=await this.database;
    int result= await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
 }

 Future<int> getCount() async{
    Database db= await this.database;
    List<Map<String,dynamic>> x= await db.rawQuery('SELECT COUNT(*) from $noteTable');
    int result=Sqflite.firstIntValue(x);
    return result;
 }

  Future<List<NoteModel>> getNoteList() async {

    var noteMapList = await getNoteMaplist(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<NoteModel> noteList = List<NoteModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(NoteModel.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }







}

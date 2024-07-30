import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:cal_app/models/event.dart';
import 'package:cal_app/models/task.dart';
import 'package:cal_app/models/settings.dart';

class mainDatabase{
  //Creates a constuctor for the database.
  static final  mainDatabase instance =  mainDatabase._init();
  static Database? _database;
  mainDatabase._init();

  //Opens connection to database.
  Future<Database> get database async{
    if(_database != null) {
      return _database!;
    }
    _database = await _initDB('database.db');
    return _database!;
  }

  //Gets path for database.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version:1, onCreate: _createDB);
  }

  //Initialises database.
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableEvents(
        ${EventFields.id} $idType,
        ${EventFields.name} $textType,
        ${EventFields.description} $textType,
        ${EventFields.dueDate} $textType,
        ${EventFields.repeatFrequency} $textType,
        ${EventFields.duration} $textType
      )''');
    await db.execute('''
      CREATE TABLE $tableTasks(
        ${TaskFields.id} $idType,
        ${TaskFields.repeatDelay} $textType,
        ${TaskFields.dueDate} $textType,
        ${TaskFields.name} $textType,
        ${TaskFields.completed} $textType,
        ${TaskFields.description} $textType
      )''');
    /*
    await db.execute('''
      CREATE TABLE $tableSettings(
        ${SettingsFields.theme} $textType,
      )''');
      */
  }


  //see CRUD operations --------------------------------------------------------------------------------------------
  //Method to create database entries
  Future<Event> createEvent(Event event) async{
    final db = await instance.database;
    
    final id = await db.insert(tableEvents, event.toMap());
    return event.copy(id: id);
  }

  Future<Event> readEvent(int id) async{
    final db = await instance.database;

    final map = await db.query(
      tableEvents,
      columns: EventFields.values,
      where: '${EventFields.id} = ?',
      //prevents sql injection.
      whereArgs: [id],
    );

    if(map.isNotEmpty){
      return Event.fromMap(map.first);
    } else {
      throw Exception('Id number $id not found.');
    }
  }

  Future<List<Event>> readAllEvents() async{
    final db = await instance.database;

    final order = '${EventFields.dueDate} ASC';
    final output = await db.query(tableEvents, orderBy: order);

    return output.map((map) => Event.fromMap(map)).toList();
  }

  Future<int> updateEvent(Event event) async{
    final db = await instance.database;

    return db.update(
      tableEvents,
      event.toMap(),
      where: '${EventFields.id} = ?',
      whereArgs: [event.id],
    );
  }

  Future<int> deleteEvent(int id) async{
    final db = await instance.database;

    return await db.delete(
      tableEvents,
      where: '${EventFields.id} = ?',
      whereArgs: [id],
    );
  }

  //CRUD events for a task ---------------------------------------------------------------------------

  Future<Task> createTask(Task task) async{
    final db = await instance.database;

    final id = await db.insert(tableTasks, task.toMap());
    return task.copy(id: id);
  }

  Future<Task> readTask(int id) async{
    final db = await instance.database;

    final map = await db.query(
      tableTasks,
      columns: TaskFields.values,
      where: '${TaskFields.id} = ?',
      //prevents sql injection.
      whereArgs: [id],
    );

    if(map.isNotEmpty){
      return Task.fromMap(map.first);
    } else {
      throw Exception('Id number $id not found.');
    }
  }

  Future<List<Task>> readAllTasks() async{
    final db = await instance.database;

    final order = '${TaskFields.dueDate} ASC';
    final output = await db.query(tableTasks, orderBy: order);

    return output.map((map) => Task.fromMap(map)).toList();
  }

  Future<int> updateTask(Task task) async{
    final db = await instance.database;

    return db.update(
      tableTasks,
      task.toMap(),
      where: '${TaskFields.id} = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int? id) async{
    final db = await instance.database;

    return await db.delete(
      tableTasks,
      where: '${TaskFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  //CRUD events for settings ---------------------------------------------------------------------------

  Future<Settings> createSettings(Settings settings) async{
    final db = await instance.database;
    await db.insert(tableSettings, settings.toMap());
    return settings;
  }

  Future<Settings> updateSettings(Settings settings) async{
    await deleteSettings();
    return createSettings(settings);
  }

  Future<List<Settings>> readSettings() async{
    final db = await instance.database;

    final output = await db.query(tableSettings);

    return output.map((map) => Settings.fromMap(map)).toList();
  }

  Future<int> deleteSettings() async{
  final db = await instance.database;

  return await db.delete(tableSettings);
  }
}

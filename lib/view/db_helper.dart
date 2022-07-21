import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/todo.dart';

final String  table= 'todo_tarefas';

class Db_view{
  static final Db_view _instance =  Db_view.internal();// não precisa entender
  factory Db_view() => _instance;// não precisa entender
  Db_view.internal();// não precisa entender

  Database? _db;

  Future<Database>get db async{
    if(_db != null){
      return _db!;
    }else{
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async{// inicializa o banco de dados
    final databasePath = await  getDatabasesPath();// pega o caminho onde está feito
    final path = join(databasePath,'todo2.db');

    return openDatabase(
      path, version:1,
      onCreate: (Database db, int version) async{
        await db.execute(
           """CREATE TABLE $table(
                id INTEGER PRIMARY KEY, tarefa TEXT, data TEXT
           )

           """
        );
      } );
  }

  Future<Todo> saveTodo(Todo todo) async{
    // print(todo);
    // print('-----------------------------------------');
    // print(todo.id);
    Database dbTodo = await db;
    todo.id = await dbTodo.insert(table, todo.toMap());
    // print(todo);
    // print('-----------------------------------------');
    // print(todo.id);
    return todo;
    
  }

  // Future<Todo> getTodo(int id) async{
  //   Database dbTodo = await db;
  //   List<Map> maps = await dbTodo.query(table,
  //     columns: ['id','tarefa','data']);
  // }

  Future<int> deleteTodo(int id) async{// o delete retorna um numero inteiro
    Database dbTodo = await db;
    return await dbTodo.delete(table, where: 'id = ?', whereArgs:[id]);
  }
  
  Future<int> atualizarTodo(Todo todo) async{// o delete retorna um numero inteiro
    Database dbTodo = await db;
    return await dbTodo.update(table, todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<List> pegarTodosTodo()async{
    Database dbTodo = await db;
    List listMap = await dbTodo.rawQuery("SELECT * FROM $table;");// pega todas as tables
    List<Todo>  listTodo = [];
    for(Map m in listMap){
      print('---------------dados d M $m');
      listTodo.add(Todo.FromMap(m));
      print(listTodo);
    }
    return listTodo;
  }

  Future<int?> getTamanho() async{
    Database dbTodo =await db;
    return Sqflite.firstIntValue(await dbTodo.rawQuery("SELECT COUNT(*) FROM $table"));
  }

   Future<int> deleteAll() async{
    Database dbTodo = await db;
    return dbTodo.rawDelete('DELETE FROM $table');
  }

  Future fechardb() async{
    Database dbTodo = await db;
    dbTodo.close();
  }

 

}

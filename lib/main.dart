import 'package:flutter/material.dart';
import 'package:trilhaapp/models/dados_cadastrais_model.dart';
import 'package:trilhaapp/models/tarefa_hive_model.dart';
import 'package:trilhaapp/pages/my_app.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Map<int, String> scripts = {
//   1: '''CREATE TABLE tarefas(
//     id INT PRIMARY KEY AUTOINCREMENT,
//     descricao TEXT,
//     concluido INTEGER
//   );'''
// }; 

// Future iniciarBancoDeDados() async {
//   var db = await openDatabase(
//     path.join(await getDatabasesPath(), 'database.db'),
//     version: scripts.length,
//     onCreate: (Database db, int index) async {
//       for (var i = 1; i <= scripts.length; i++) {
//         await db.execute(scripts[i]!);
//         debugPrint(scripts[i]);
//       }
//     },
//     onUpgrade: (Database db, int oldVersion, int newVersion) async {
//         for (var i = oldVersion + 1; i <= scripts.length; i++) {
//           await db.execute(scripts[i]!);
//           debugPrint(scripts[i]);
//         }
//     }
//   );
//   return db;
// }

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // var documentsDirectory = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;
  // await iniciarBancoDeDados();
  runApp(const MyApp());
}

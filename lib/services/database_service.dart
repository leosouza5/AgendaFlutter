import 'dart:async';

import 'package:agenda/features/contato/model/contato_model.dart';
import 'package:agenda/features/telaDeLogin/model/usuario_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._constructor();

  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String nomeDaTabela = "tb_contatos";
  final String nomeDaTabelaUsuario = "tb_usuario";

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await getDatabase();
      return _db!;
    }
  }

  Future<Database> getDatabase() async {
    final databaseDir = await getDatabasesPath();

    final databasePath = join(databaseDir, "agenda_db.db");
    final database = await openDatabase(
      version: 1,
      databasePath,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $nomeDaTabelaUsuario(
            id INTEGER PRIMARY KEY,
            usuario TEXT NOT NULL,
            senha TEXT NOT NULL
          )
        ''');
        db.execute('''
          CREATE TABLE $nomeDaTabela(
            id INTEGER PRIMARY KEY,
            nome TEXT NOT NULL,
            email TEXT NOT NULL,
            numero TEXT NOT NULL
          )
        ''');
      },
      onOpen: (db) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $nomeDaTabelaUsuario(
            id INTEGER PRIMARY KEY,
            usuario TEXT NOT NULL,
            senha TEXT NOT NULL
          )
        ''');
      },
    );
    return database;
  }

  Future<void> novoUsuario({required UsuarioModel contato}) async {
    final db = await database;
    print(db);

    db.insert(
      nomeDaTabelaUsuario,
      {
        "usuario": contato.usuario,
        "senha": contato.senha,
      },
    );
  }

  Future<bool> verificarLogin({required UsuarioModel usuarioModel}) async {
    final db = await database;

    final resultado = await db.query(
      nomeDaTabelaUsuario,
      where: 'usuario = ? AND senha = ?',
      whereArgs: [usuarioModel.usuario, usuarioModel.senha],
    );
    return resultado.isNotEmpty;
  }

  void novoContato({required ContatoModel contato}) async {
    final db = await database;

    db.insert(
      nomeDaTabela,
      {
        "nome": contato.nome,
        "email": contato.email,
        "numero": contato.numero,
      },
    );
  }

  Future<List<ContatoModel>> recuperaContatos() async {
    final db = await database;

    final contatos = await db.query(nomeDaTabela);

    return contatos
        .map(
          (e) => ContatoModel(
            id: e['id'] as int,
            nome: e['nome'].toString(),
            numero: e['numero'].toString(),
            email: e['email'].toString(),
          ),
        )
        .toList();
  }

  Future<void> updateContato(ContatoModel contato) async {
    final db = await database;

    await db.update(
        nomeDaTabela,
        {
          "nome": contato.nome,
          "email": contato.email,
          "numero": contato.numero,
        },
        where: 'id = ?',
        whereArgs: [contato.id!]);
  }

  Future<void> deleteContato(int id) async {
    final db = await database;

    await db.delete(nomeDaTabela, where: 'id = ?', whereArgs: [id]);
  }
}

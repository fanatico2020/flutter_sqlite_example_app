import 'package:flutter/material.dart';

import 'database/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dataBase();
  }

  Future<void> _dataBase() async {
    var database = await DatabaseSqlite().openConnection();
    database.insert('teste', {'nome:': 'Italo Ramon'});
    database.delete('teste', where: 'nome = ?', whereArgs: ['Italo Ramon']);
    database.update('teste', {'nome': 'Lima cunha'},
        where: 'nome = ?', whereArgs: ['Italo Ramon']);
    //var result = await = database.query('teste');
    //database.rawInsert('sql');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Container(),
    );
  }
}

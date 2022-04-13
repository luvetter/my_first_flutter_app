import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/domain/index.dart';
import 'package:my_first_flutter_app/todo_tile_lukas.dart';

void main() {
  runApp(const MyApp());
}

const String kHelloWorld = 'Hello World';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo's",
      home: MyHomePage(title: "Todo's"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String name = 'Workshop';

  final List<Todo> todos = const [
    Todo(
      uid: 'uid',
      name: 'App schreiben',
      description: 'Ich muss supda dupa App schreiben!!!!',
    ),
    Todo(
      uid: 'uid2',
      name: 'App verbessern',
      description: 'NFTs einbauen?',
    ),
    Todo(
      uid: 'uid3',
      name: 'Kaffee trinken',
      description: 'Das sollte immer Prio haben',
    ),
    Todo(
      uid: 'uid',
      name: 'App schreiben',
      description: 'Ich muss supda dupa App schreiben!!!!',
    ),
    Todo(
      uid: 'uid2',
      name: 'App verbessern',
      description: 'NFTs einbauen?',
    ),
    Todo(
      uid: 'uid3',
      name: 'Kaffee trinken',
      description: 'Das sollte immer Prio haben',
    ),
    Todo(
      uid: 'uid',
      name: 'App schreiben',
      description: 'Ich muss supda dupa App schreiben!!!!',
    ),
    Todo(
      uid: 'uid2',
      name: 'App verbessern',
      description: 'NFTs einbauen?',
    ),
    Todo(
      uid: 'uid3',
      name: 'Kaffee trinken',
      description: 'Das sollte immer Prio haben',
    ),
    Todo(
      uid: 'uid',
      name: 'App schreiben',
      description: 'Ich muss supda dupa App schreiben!!!!',
    ),
    Todo(
      uid: 'uid2',
      name: 'App verbessern',
      description: 'NFTs einbauen?',
    ),
    Todo(
      uid: 'uid3',
      name: 'Kaffee trinken',
      description: 'Das sollte immer Prio haben',
    ),
    Todo(
      uid: 'uid',
      name: 'App schreiben',
      description: 'Ich muss supda dupa App schreiben!!!!',
    ),
    Todo(
      uid: 'uid2',
      name: 'App verbessern',
      description: 'NFTs einbauen?',
    ),   Todo(
      uid: 'uid2',
      name: 'App verbessern',
      description: 'NFTs einbauen?',
    ),
    Todo(
      uid: 'uid3',
      name: 'Kaffee trinken',
      description: 'Das sollte immer Prio haben',
    ),
    Todo(
      uid: 'uid',
      name: 'App schreiben',
      description: 'Ich muss supda dupa App schreiben!!!!',
    ),
    Todo(
      uid: 'uid2',
      name: 'App verbessern',
      description: 'NFTs einbauen?',
    ),
  ];

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Text(name, style: Theme.of(context).textTheme.headline3),
          Flexible(
            child: ListView(
              children: [
                ...todos.map((todo) => TodoTile(todo: todo)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

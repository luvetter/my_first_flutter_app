import 'package:faker/faker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/create_todo_page.dart';
import 'package:my_first_flutter_app/domain/repository.dart';
import 'package:my_first_flutter_app/firebase_options.dart';
import 'package:my_first_flutter_app/todo_list.dart';
import 'package:my_first_flutter_app/todo_list_selector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

const String kHelloWorld = 'Hello World';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Todo's",
      home: MyHomePage(title: "Todo's"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TodoRepository repository = FirestoreTodoRepository();
  String? _todoList;

  @override
  void initState() {
    super.initState();
    repository.createTodoList('Workshop');
  }

  // Name nicht scrollable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<String>>(
        stream: repository.streamTodoLists(),
        builder: (context, snapshot) {
          if (_todoList == null || !(snapshot.data?.contains(_todoList) ?? false)) {
            _todoList = snapshot.data?.first;
          }
          return Column(
            children: [
              TodoListSelector(
                lists: snapshot.data ?? [],
                currentList: _todoList,
                onChanged: (s) {
                  setState(() {
                    _todoList = s;
                  });
                },
              ),
              if (_todoList != null)
                Flexible(
                  child: TodoListView(
                    repository: repository,
                    todoList: _todoList!,
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: _todoList != null
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CreateTodoPage(
                      repository: repository,
                      todoList: _todoList!,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

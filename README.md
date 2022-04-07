# Aufgabe 1: Startet die App

In VS-Code:
- Wähle unten rechts als Device "Chrome" oder dein Android-Gerät aus. Dort ist möglicherweise Windows vorausgewählt.
- Öffne in der Rail-Bar links das Run and Debug Menü
- Wähle in den Menü oben in der Dropdown-Box "run app (debug mode)" aus und klick auf den grünen Pfeil daneben

In IntelliJ:
- In der Kontrollleiste oben solltst du "Chrome" oder dein Android-Gerät auswählen können
- Als Run-Configuration sollte automatisch die "main.dart" erkannt worden sein
- Debug ausführen 

# Aufgabe 2: Todo-Liste anzeigen

## 2.1 Ein Todo anzeigen

Als erstes wollen wir nur ein Todo anzeigen. Dazu fügen wir in MyHomePage folgendes Feld ein:
````dart
final Todo todo = const Todo(
    uid: 'uid',
    name: 'App schreiben',
    description: 'Ich muss supda dupa App schreiben!!!!',
  );
````

Jetzt könnten wir kHelloWorld einfach durch todo.name oder todo.description austauschen. Aber wir wollen ja gerne beides anzeigen.
Dafür könnten wir simple String-Interpolation nutzten, dann würde unsere Text-String so aussehen: '${todo.name} : ${todo.description}'.
Um das ganze Etwas leserlicher zu bekommen, wollen wir Name und Description allerdings untereinander bekommen. Flutter würde uns dafür auch
schon ein passendes Widget anbieten: das ListTile
````dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Center(
      child: ListTile(
        title: Text(todo.name),
        subtitle: Text(todo.description),
      ),
    ),
  );
}
````

Für diese Aufgabe verwenden wir aber eine Column. Das ist ein zentrales Layout-Element und wir wollen damit Erfahrung sammeln.

````dart
  @override
  Widget build(BuildContext context) {
    ListTile;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.name,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Text(
              todo.description,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context).textTheme.caption?.color,
                  ),
            ),
          ],
        ),
      ),
    );
  }
````

## 2.2 Mehrere Todos anzeigen

I.d.R haben wir ja mehr als Todo, daher machen wir aus unserem einem Todo erstmal eine List von Todos:
````dart
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
  ];
````

Wir möchten jetzt natürlich alle Todos anzeigen, nicht nur eins. Eine erste Idee könnte sein, die Texte immer zu duplizieren und für jedes Todo 
anzuzeigen. Das macht es aber auf Dauer schwer zu erkennen, wo ein Todo anfängt und wieder aufhört. Besser ist da schon unsere bestehende "Todo-Column"
in einen neue "Todos-Column" zu packen und dann für jedes Todo dort eine eigene "Todo-Column" anzuzeigen:
```dart
  @override
  Widget build(BuildContext context) {
    ListTile;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todos[0].name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  todos[0].description,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context).textTheme.caption?.color,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todos[1].name,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Text(
                  todos[1].description,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: Theme.of(context).textTheme.caption?.color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
```

Man stellt aber schnell fest, dass das sehr lang werden kann und man Anpassungen für jedes Todo einzeln machen muss. Daher verschieben wir den 
Code für ein Todo in eine eigene Klasse und rufen nur noch die in der Haupt-Column auf:
```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TodoTile(todo: todos[0]),
            TodoTile(todo: todos[1]),
            TodoTile(todo: todos[2]),
          ],
        ),
      ),
    );
  }
```
Um jetzt noch unabhängig von der Anzhal unsere Todos zu werden, verwenden die map-Funktion, die jedes Iterable in dart mitbringt:
```dart
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(title),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: todos.map((todo) => TodoTile(todo: todo)).toList(),
      ),
    ),
  );
}
```
Jetzt können wir beliebig viele Todos in die Liste einfügen, können aber auch mehr haben, als auf den Bildschirm passen. Da wäre es gut, wenn unsere
Liste scrollen könnte. Als einfache Lösung dafür können wir unsere Column in ein SingleChildScrollView wrappen. Wir können allerdings auch die Column 
durch ein ListView ersetzt. Das hat vor allem bei sehr großen Listen Performance-Vorteile, da es nicht direkt alle Elemente rendert.

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: todos.map((todo) => TodoTile(todo: todo)).toList(),
      ),
    );
  }
```

## 2.3 Todo-liste mit Namen

Unsere Todo-liste soll einen Namen bekommen, auch um später vll. verschiedene Listen zu unterscheiden. Dafür ersetzten wir unsere Liste von Todos
durch eine TodoList und geben dieser den Namen 'Workshop'. In unsere build-Methode müssen nun die Todos aus der TodoList verwenden:
```dart
  final TodoList todolist = const TodoList(
    name: 'Workshop',
    todos: [
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
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: todolist.todos.map((todo) => TodoTile(todo: todo)).toList(),
      ),
    );
  }
```

Nun müssen wir uns entscheiden, ob der Name der Liste mitscrollen soll oder nicht. Um den ihn mitscrollen zu lassen, packen wir ihn mit in das ListView
als erstes Element. Dafür geben wir dem ListView nicht mehr direkt die Liste der TodoTiles, sondern eine neue Liste, in der als erstes Element ein
Text mit dem Listennamen ist. Die TodoTiles fügen dann über die Sperad-Operator '...' ein. Dieser erlaubt es alle Elemente einer List direkt in eine
andere Liste einzufügen.
```dart
  // Name scrollable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          Text(
            todolist.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          ...todolist.todos.map((todo) => TodoTile(todo: todo)),
        ],
      ),
    );
  }
```

Allerdings hat es auch seine Vorteile, wenn der Name oben stehen bleibt, auch wenn wir bis Element 300 scrollen. Also möchten wir den Namen über
unsere Liste anzeigen -> Column. Aber, wenn wir eine Column aus Text und ListView haben, sehen wir auf einmal garnichts mehr.
Der Grund dafür ist, dass eine Column standardmäßig unendlich groß ist und das ListView versucht so groß zu werden wie möglich, was bei einer Größe
von unendlich zu einem Fehler führt. Wir könnten beim ListView zwar shrinkWrap = true setzten, um diese Verhalten zu unterdrücken und würden dann
auch unsere Liste wieder sehen, aber dann würde das ListView trotzdem denken, dass es komplett in die Column passt und nie scrollbar werden.
Stattdessen wrappen wir das ListView mit einem Flexible. Ein Flexible bekommt von der Column mitgeteilt, wie viel Platz es echt haben kann und kann
dies seinem Child (unserem ListView) mitteilen:
````dart
  // Name nicht scrollable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Text(
            todolist.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: todolist.todos.map((todo) => TodoTile(todo: todo)).toList(),
            ),
          ),
        ],
      ),
    );
  }
````

# Aufgabe 3 Todos hinzufügen

Wir wollen über einen Button neuer (zufällige) Todos anlegen. Dafür fügen wir unserm Scaffold einen Floating-Action-Button hinzu. Damit dieser 
unser Widget aber aktualisieren kann, müssen wir daraus ein StatefullWidget machen und dem Button sagen, dass er die setState-Methode aufrufen muss:
```dart
  floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          todolist.todos.add(
            Todo(
              uid: 'uid${todolist.todos.length}',
              name: 'Kaffee trinken',
              description: 'Das sollte immer Prio haben',
            ),
          );
        }),
```

manulles update
```dart

class _MyHomePageState extends State<MyHomePage> {
  final TodoRepository repository = InMemTodoRepository();
  final _todoList = 'Workshop';

  @override
  void initState() {
    super.initState();
    repository.createTodoList(_todoList);
  }

  // Name nicht scrollable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(
            _todoList,
            style: Theme.of(context).textTheme.headline3,
          ),
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: repository
                  .findTodos(_todoList)
                  .map((todo) => TodoTile(todo: todo))
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          var faker = Faker();
          repository.createTodo(
            list: _todoList,
            name: faker.lorem.sentence(),
            description: faker.lorem.sentence(),
          );
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

streambuilder
```dart
  // Name nicht scrollable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(
            _todoList,
            style: Theme.of(context).textTheme.headline3,
          ),
          Flexible(
            child: StreamBuilder<List<Todo>>(
                stream: repository.streamTodos(_todoList),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!
                          .map((todo) => TodoTile(todo: todo))
                          .toList(),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var faker = Faker();
          repository.createTodo(
            list: _todoList,
            name: faker.lorem.sentence(),
            description: faker.lorem.sentence(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
```

Liste mit StreamLBuilder als eigenes Widget rausziehen

```dart
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
                var faker = Faker();
                repository.createTodo(
                  list: _todoList!,
                  name: faker.lorem.sentence(),
                  description: faker.lorem.sentence(),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
```

```dart
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
```
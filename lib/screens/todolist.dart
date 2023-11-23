import 'package:flutter/material.dart';
import 'package:todoapp/model/todo.dart';
import 'package:todoapp/util/dbhelper.dart';
import 'package:todoapp/screens/tododetail.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<StatefulWidget> createState() => TodoListState();
}

class TodoListState extends State {
  DbHelper helper = DbHelper();
  List<Todo>? todos;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todos == null) {
      todos = List<Todo>.empty(growable: true);
      getData();
    }
    return Scaffold(
      body: todoListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Todo('', 3, ''));
        },
        tooltip: "Add new Todo",
        child: new Icon(Icons.add),
      ),
    );
  }

  ListView todoListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: getColor(todos![position].priority),
                  child: Text(
                    todos![position].priority.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(todos![position].title.toString()),
                subtitle: Text(todos![position].date.toString()),
                onTap: () {
                  debugPrint("Tapped on " + todos![position].id.toString());
                  navigateToDetail(todos![position]);
                }));
      },
    );
  }

  void getData() {
    // open db which is async;
    final dbFuture = helper.intializeDb();
    dbFuture.then((result) {
      // get todo which is async
      final todosFuture = helper.getTodos();
      todosFuture.then((result) {
        List<Todo> todoList = List<Todo>.empty(growable: true);
        count = result!.length;
        for (int i = 0; i < count; i++) {
          // adding todo result individually
          todoList.add(Todo.fromObject(result[i]));
          debugPrint(todoList[i].title);
        }
        setState(() {
          todos = todoList;
          count = count;
        });
        debugPrint("items" + count.toString());
      });
    });
  }

  Color getColor(int? priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.green;

      default:
        return Colors.green;
    }
  }

  void navigateToDetail(Todo todo) async {
    print(todo);
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoDetail(todo)),
    );
    // when the operation success
    if (result == true) {
      getData();
    }

  }
}

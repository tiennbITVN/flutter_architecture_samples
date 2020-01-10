import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/todo_list_model.dart';
import 'package:todos_app_core/todos_app_core.dart';

import 'edit_todo_screen.dart';
import 'models.dart';

class DetailsScreen extends StatelessWidget {
  final String id;
  final VoidCallback onRemove;

  const DetailsScreen({@required this.id, @required this.onRemove})
      : super(key: ArchSampleKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TodoListModel>(context);
    final todo = model.todoById(id) ?? Todo('');

    return Scaffold(
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).todoDetails),
        actions: <Widget>[
          IconButton(
            key: ArchSampleKeys.deleteTodoButton,
            tooltip: ArchSampleLocalizations.of(context).deleteTodo,
            icon: const Icon(Icons.delete),
            onPressed: onRemove,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.editTodoFab,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTodoScreen(
                id: id,
                onEdit: (task, note) {
                  Provider.of<TodoListModel>(context, listen: false).updateTodo(
                    todo.copy(task: task, note: note),
                  );

                  return Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    key: ArchSampleKeys.detailsTodoItemCheckbox,
                    value: todo.complete,
                    onChanged: (complete) {
                      model.updateTodo(todo.copy(complete: !todo.complete));
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          todo.task,
                          key: ArchSampleKeys.detailsTodoItemTask,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      Text(
                        todo.note,
                        key: ArchSampleKeys.detailsTodoItemNote,
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

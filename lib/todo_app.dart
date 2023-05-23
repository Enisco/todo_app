import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/bloc.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      home: BlocProvider(
        create: (context) => TodoBloc(),
        child: TodoScreen(),
      ),
    );
  }
}

class TodoScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoBloc = BlocProvider.of<TodoBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            onPressed: () {
              Todo newTodo = Todo(
                title: _titleController.text,
                description: _descriptionController.text,
              );
              todoBloc.add(AddTodoEvent(newTodo));
              _titleController.clear();
              _descriptionController.clear();
            },
            child: const Text('Add Todo'),
          ),
          Expanded(
            child: BlocBuilder<TodoBloc, List<Todo>>(
              builder: (context, todos) {
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return ListTile(
                      leading: Checkbox(
                        value: todo.isDone,
                        onChanged: (_) {
                          todoBloc.add(ToggleTodoEvent(index));
                        },
                      ),
                      title: Text(todo.title),
                      subtitle: Text(todo.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          todoBloc.add(DeleteTodoEvent(index));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

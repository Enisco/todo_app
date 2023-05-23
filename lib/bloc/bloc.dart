import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/models/todo_model.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent(this.todo);
}

class ToggleTodoEvent extends TodoEvent {
  final int index;

  ToggleTodoEvent(this.index);
}

class DeleteTodoEvent extends TodoEvent {
  final int index;

  DeleteTodoEvent(this.index);
}

class TodoBloc extends Bloc<TodoEvent, List<Todo>> {
  TodoBloc() : super([]);

  @override
  Stream<List<Todo>> mapEventToState(TodoEvent event) async* {
    if (event is AddTodoEvent) {
      List<Todo> updatedTodos = List.from(state);
      updatedTodos.add(event.todo);
      yield updatedTodos;
    } else if (event is ToggleTodoEvent) {
      List<Todo> updatedTodos = List.from(state);
      updatedTodos[event.index].isDone = !updatedTodos[event.index].isDone;
      yield updatedTodos;
    } else if (event is DeleteTodoEvent) {
      List<Todo> updatedTodos = List.from(state);
      updatedTodos.removeAt(event.index);
      yield updatedTodos;
    }
  }
}

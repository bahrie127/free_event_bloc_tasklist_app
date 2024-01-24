part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskEvent {}

class DoAddTaskEvent extends AddTaskEvent {
  final String title;
  final String description;

  DoAddTaskEvent(this.title, this.description);
}

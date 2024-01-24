part of 'add_task_bloc.dart';

@immutable
sealed class AddTaskState {}

final class AddTaskInitial extends AddTaskState {}

final class AddTaskLoading extends AddTaskState {}

final class AddTaskSuccess extends AddTaskState {}

final class AddTaskFailure extends AddTaskState {
  final String message;

  AddTaskFailure(this.message);
}

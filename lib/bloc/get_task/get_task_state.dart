part of 'get_task_bloc.dart';

@immutable
sealed class GetTaskState {}

final class GetTaskInitial extends GetTaskState {}

final class GetTaskLoading extends GetTaskState {}

final class GetTaskSuccess extends GetTaskState {
  final List<Task> tasks;

  GetTaskSuccess(this.tasks);
}

final class GetTaskFailure extends GetTaskState {
  final String message;

  GetTaskFailure(this.message);
}
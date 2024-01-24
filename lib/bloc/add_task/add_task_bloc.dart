import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasources/task_remote_datasource.dart';
import '../../data/models/add_task_request_model.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final TaskRemoteDatasource taskRemoteDatasource;
  AddTaskBloc(
    this.taskRemoteDatasource,
  ) : super(AddTaskInitial()) {
    on<DoAddTaskEvent>((event, emit) async {
      emit(AddTaskLoading());
      await Future.delayed(const Duration(seconds: 5));
      try {
        await taskRemoteDatasource.addTask(
          AddTaskRequestModel(
            data: Data(
              title: event.title,
              description: event.description,
            ),
          ),
        );
        emit(AddTaskSuccess());
      } catch (e) {
        emit(AddTaskFailure(e.toString()));
      }
    });
  }
}

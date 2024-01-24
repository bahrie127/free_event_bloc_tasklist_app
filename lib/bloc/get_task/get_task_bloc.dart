import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/datasources/task_remote_datasource.dart';
import '../../data/models/task_response_model.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';

class GetTaskBloc extends Bloc<GetTaskEvent, GetTaskState> {
  final TaskRemoteDatasource taskRemoteDatasource;
  GetTaskBloc(
    this.taskRemoteDatasource,
  ) : super(GetTaskInitial()) {
    on<DoGetAllTaskEvent>((event, emit) async {
      emit(GetTaskLoading());
      await Future.delayed(const Duration(seconds: 5));
      try {
        final model = await taskRemoteDatasource.getTasks();
        emit(GetTaskSuccess(model.data));
      } catch (e) {
        emit(GetTaskFailure(e.toString()));
      }
    });
  }
}

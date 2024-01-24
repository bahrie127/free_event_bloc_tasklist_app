import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasklist_app/bloc/add_task/add_task_bloc.dart';
import 'package:flutter_tasklist_app/bloc/get_task/get_task_bloc.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';
import 'package:flutter_tasklist_app/data/models/add_task_request_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //titlecontroller
  //descriptioncontroller
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          TextField(
            controller: titlecontroller,
            decoration: const InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptioncontroller,
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          BlocConsumer<AddTaskBloc, AddTaskState>(
            listener: (context, state) {
              if (state is AddTaskSuccess) {
                context.read<GetTaskBloc>().add(DoGetAllTaskEvent());
                Navigator.pop(context);
              }
              if (state is AddTaskFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AddTaskLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                onPressed: () {
                  context.read<AddTaskBloc>().add(
                        DoAddTaskEvent(
                          titlecontroller.text,
                          descriptioncontroller.text,
                        ),
                      );
                  // final model = AddTaskRequestModel(
                  //   data: Data(
                  //       title: titlecontroller.text,
                  //       description: descriptioncontroller.text),
                  // );
                  // final response = await TaskRemoteDatasource().addTask(model);
                  // Navigator.pop(context);
                },
                child: const Text('Add'),
              );
            },
          ),
        ],
      ),
    );
  }
}

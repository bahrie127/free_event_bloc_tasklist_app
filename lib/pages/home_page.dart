import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';
import 'package:flutter_tasklist_app/data/models/task_response_model.dart';
import 'package:flutter_tasklist_app/pages/detail_task_page.dart';

import '../bloc/get_task/get_task_bloc.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool isLoaded = false;

  // List<Task> tasks = [];

  // Future<void> getTasks() async {
  //   setState(() {
  //     isLoaded = true;
  //   });
  //   final model = await TaskRemoteDatasource().getTasks();
  //   tasks = model.data;

  //   setState(() {
  //     isLoaded = false;
  //   });
  // }

  @override
  void initState() {
    context.read<GetTaskBloc>().add(DoGetAllTaskEvent());
    // getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Task List',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<GetTaskBloc, GetTaskState>(
        builder: (context, state) {
          if (state is GetTaskLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetTaskFailure) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is GetTaskInitial) {
            return const Center(
              child: Text('No Data'),
            );
          }

          final tasks = (state as GetTaskSuccess).tasks;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DetailTaskPage(
                      task: tasks[index],
                    );
                  }));
                },
                child: Card(
                  child: ListTile(
                    title: Text(tasks[index].attributes.title),
                    subtitle: Text(tasks[index].attributes.description),
                    trailing: const Icon(Icons.check_circle),
                  ),
                ),
              );
            },
            itemCount: tasks.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddTaskPage();
          }));
          // getTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

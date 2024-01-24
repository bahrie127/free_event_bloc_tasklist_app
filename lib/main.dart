import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasklist_app/bloc/add_task/add_task_bloc.dart';
import 'package:flutter_tasklist_app/data/datasources/task_remote_datasource.dart';
import 'package:flutter_tasklist_app/pages/home_page.dart';

import 'bloc/get_task/get_task_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetTaskBloc(TaskRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => AddTaskBloc(TaskRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}

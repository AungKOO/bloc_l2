import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_l2/network/api_service.dart';
import 'package:bloc_l2/network/model/task_model.dart';
import 'package:flutter/material.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc(this.api) : super(TaskInitial());

  final ApiService api;

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is GetTaskEvent) {
      yield LoadingTaskState();
      try {
        final response = await api.getTasks();
        yield LoadedTaskState(response);
      } on SocketException catch (e) {
        yield FailedTaskState(e.toString());
        print(e);
      } on Exception catch (e) {
        yield FailedTaskState(e.toString());
        print(e);
      }
    }
  }
}

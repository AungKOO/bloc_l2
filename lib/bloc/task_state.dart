part of 'task_bloc.dart';

@immutable
abstract class TaskState {}

class TaskInitial extends TaskState {}

class LoadingTaskState extends TaskState {}

class LoadedTaskState extends TaskState {
  final List<TaskModel> taskModels;
  LoadedTaskState(this.taskModels);
}

class FailedTaskState extends TaskState {
  final String error;
  FailedTaskState(this.error);
}

import 'package:bloc_l2/bloc/task_bloc.dart';
import 'package:bloc_l2/network/api_service.dart';
import 'package:bloc_l2/ui/my_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (context) => ApiService.create(),
      child: Consumer<ApiService>(builder: (context, apiService, child) {
        return BlocProvider<TaskBloc>(
          create: (context) => TaskBloc(apiService),
          child: MaterialApp(
            title: "Test BloC",
            theme: ThemeData.dark().copyWith(
              primaryColor: Color(0xff183D5D),
              scaffoldBackgroundColor: Color(0xff072540),
              cardColor: Color(0xff183D5D),
            ),
            home: MyHome(),
          ),
        );
      }),
    );
  }
}
